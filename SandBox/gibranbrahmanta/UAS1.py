import hashlib
from datetime import datetime as dt

SCRIPT_FORMAT = '%d %b %Y %I:%M:%S %p'
COMMAND_FORMAT = '%y%m%d-%H%M%S'

def read_file(filename):
	file = open(filename, "r")
	return file.read().splitlines()

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

def check_file(content, owner):
	seq_flag = ""
	sum_flag = ""
	username = content[3]
	line = ""
	res = ""
	time = ""
	command = ""
	tmp_date = None
	compare_date = None
	tmp_lst = []
	hash_res = ""
	for i in range(len(content)):
		if i == 0:
			tmp_date = convert_datetime(" ".join(content[i].split()[4:9]), SCRIPT_FORMAT)
			time = datetime_to_string(tmp_date)
			res += "{} ZCZCSCRIPTSTART {} {}\n".format(owner, time, username)
		if i == len(content)-1:
			compare_date =  convert_datetime(" ".join(content[i].split()[4:9]), SCRIPT_FORMAT)
			time = datetime_to_string(compare_date)
			if tmp_date > compare_date:
				seq_flag = "SEQNO"
			else:
				seq_flag = "SEQOK"
			res += "{} ZCZCSCRIPTSTOP {} {}".format(owner, time, seq_flag)
		else:
			line = content[i]
			if line.startswith("20"):
				tmp_lst = line.split("/")[0].split("-")
				command = "{}-{}-{}-{}".format(tmp_lst[0], tmp_lst[1], tmp_lst[2], tmp_lst[3])
				hash_res = generate_sha1( "{}-{}-{}-{}\n".format(tmp_lst[0], tmp_lst[1], username, tmp_lst[3]))
				compare_date =  convert_datetime("{}-{}".format(tmp_lst[0], tmp_lst[1]), COMMAND_FORMAT) 
				if tmp_lst[2] == hash_res[0:4]:
					sum_flag = "SUMOK"
				else:
					sum_flag = "SUMNO"
				if tmp_date > compare_date:
					seq_flag = "SEQNO"
				else:
					seq_flag = "SEQOK"
				tmp_date = compare_date
				res += "{} {} {} {} {} {} {}\n".format(owner, username, command+"/", datetime_to_string(compare_date), seq_flag, sum_flag, hash_res[0:8]) 
	return res

	
def main():
	file = input("Masukan nama file yang ingin di cek: ")
	owner = input("Masukan username akun github anda: ")
	content = read_file(file)
	result = check_file(content, owner)
	print(result)

if __name__ == '__main__':
	main()
