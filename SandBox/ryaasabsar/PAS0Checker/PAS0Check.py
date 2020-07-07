import hashlib
from datetime import datetime as dt

SCRIPT_FORMAT = '%d %b %Y %I:%M:%S %p'
COMMAND_FORMAT = '%y%m%d-%H%M%S'

def get_data(filename):
    return open(filename, "r").readlines()

def startswith(data_list, prefix):
    result = []
    for data in data_list:
        if data.startswith(prefix):
            result.append(data)
    return result

def convert_datetime(datetime, formatter):
    return dt.strptime(datetime, formatter)

def datetime_to_string(datetime):
    day = datetime.day
    month = datetime.month
    year = datetime.year
    hour = datetime.hour
    minute = datetime.minute
    second = datetime.second

    result = "{0}{1:0>2s}{2:0>2s}-{3:0>2d}{4:0>2d}{5:0>2d}".format(
        str(year)[2:], str(month), str(day),
        hour, minute, second)
    return result
    
def generate_sha1(command):
    sha_1 = hashlib.sha1(command.encode())
    return sha_1.hexdigest()

user = input("Insert your GitHub user: ")
filename = input("Insert Filename: ")
data = get_data(filename)

checked_user = filename.split(".")[0]

# Processing data and converting some date time
command_list = startswith(data, "20")
proceed_command_list = []
for i in range (len(command_list)):
    command_list[i] = command_list[i].split("/")[0].split("-")
    date = command_list[i][0]
    time = command_list[i][1]
    sha1 = command_list[i][2]
    folder_name = command_list[i][3]
    datetime = "{}-{}".format(date, time)
    proceed_command = "{}-{}-{}".format(datetime, checked_user, folder_name)
    proceed_command_list.append([proceed_command, sha1, convert_datetime(datetime, COMMAND_FORMAT)])

script_sign = startswith(data, "Script")
datetime_started = convert_datetime(" ".join(script_sign[0].split()[4:9]), SCRIPT_FORMAT)
datetime_ended = convert_datetime(" ".join(script_sign[1].split()[4:9]), SCRIPT_FORMAT)


# Generating result
result = ""
datetime_compare = datetime_started
for i in range (len(proceed_command_list)):
    seqok = "SEQNO"
    sumok = "SUMNO"
    
    if i == 0:
        datetime_convert = datetime_to_string(datetime_started)
        result += "{} ZCZCSCRIPTSTART {} {}\n".format(user, datetime_convert, checked_user)

    if datetime_compare <= proceed_command_list[i][2]:
        datetime_compare = proceed_command_list[i][2]
        seqok = "SEQOK"

    command_sha1 = generate_sha1(proceed_command_list[i][0] + "\n")
    if command_sha1[0:4] == proceed_command_list[i][1]:
        sumok = "SUMOK"

    command ="-".join(command_list[i])
    result += "{} {} {} {} {} {} {}\n".format(
        user, checked_user,
        command + "/", command[0:13],
        seqok, sumok, command_sha1[0:8])

    if i == (len(proceed_command_list)-1):
        seqok = "SEQNO"
        if datetime_compare < datetime_ended:
            datetime_compare = datetime_ended
            seqok = "SEQOK"
        
        datetime_convert = datetime_to_string(datetime_ended)
        result += "{} ZCZCSCRIPTSTOP {} {}".format(user, datetime_convert, seqok)

print(result)
