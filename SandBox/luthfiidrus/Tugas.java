import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger; 
import java.security.MessageDigest; 
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

public class Tugas { 
    public static String encryptThisString(String input) { 
        try { 
            MessageDigest md = MessageDigest.getInstance("SHA-1"); 
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 40) { 
                hashtext = "0" + hashtext; 
            }
            return hashtext; 
        } 
        catch (NoSuchAlgorithmException e) { 
            throw new RuntimeException(e); 
        } 
    }

    private static String seqCheck(String prev, String now) {
        int cek = prev.compareTo(now);
        if (cek <= 0) {
            return "SEQOK";
        }
        else {
            return "SEQNO";
        }
    }

    private static String encryptGenerator(String string, String gitHubUsername) {
        return string.substring(0, 14) + gitHubUsername + string.substring(18) + "\n";
    }

    private static String sumCheck(String prev, String forEncrypt) {
        String sum = prev.substring(14, 18);
        String sha1sum = encryptThisString(forEncrypt).substring(0, 4);
        if (sha1sum.equals(sum)) {
            return "SUMOK";
        }
        else {
            return "SUMNO";
        }
    } 

    private static String stringToDateFormat(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy", Locale.ENGLISH);
        String tanggal = LocalDate.parse(date.substring(0, 11), formatter).toString();
        String timestamp = tanggal.substring(2, 4) + tanggal.substring(5, 7) + tanggal.substring(8, 10);
        int hour = Integer.parseInt(date.substring(12, 14));
        int minute = Integer.parseInt(date.substring(15, 17));
        int sec = Integer.parseInt(date.substring(18, 20));
        if (date.substring(21, 23).equals("PM")) {
            hour += 12;
        }
        return String.format("%s-%02d%02d%02d", timestamp, hour, minute, sec);
    }

    private static String scriptOutput(ArrayList<String> list, String gitHubUsername) {
        String result = "";
        for (int i = 0; i < list.size(); i++) {
            if (i == 0) {
                result += "luthfiidrus ZCZCSCRIPTSTART " + list.get(i) + " " + gitHubUsername + "\n";
            }
            else if (i == list.size() -1) {
                result += "luthfiidrus ZCZCSCRIPTSTOP " + list.get(i) + " " + seqCheck(list.get(i-1), list.get(i));
            }
            else {
                String forEncrypt = encryptGenerator(list.get(i), gitHubUsername);
                String sha1sum = encryptThisString(forEncrypt);
                result += "luthfiidrus " + gitHubUsername + " " + list.get(i) + "/ " + list.get(i).substring(0, 13) + " " + seqCheck(list.get(i-1), list.get(i)) + " " + sumCheck(list.get(i), forEncrypt) + " " + sha1sum.substring(0, 8) + "\n";
            }
        }
        return result;
    }

    private static String generate(String gitHubUsername) {
        String forScriptTxt = "";
        try {
            BufferedReader br = new BufferedReader(new FileReader(gitHubUsername + "/0001-mytest.txt"));
            ArrayList<String> list = new ArrayList<>();
            String stringReader;
            while ((stringReader = br.readLine()) != null) {
                if (stringReader.contains("Script started")) {
                    String converted = stringToDateFormat(stringReader.substring(22, 45));
                    list.add(converted);
                }
                else if (stringReader.contains("Script done")) {
                    String converted = stringToDateFormat(stringReader.substring(19, 42));
                    list.add(converted);
                }
                else if (stringReader.contains("/>") && !stringReader.contains("}/>")) {
                    list.add(stringReader.substring(0, stringReader.indexOf("/")));
                }
            }
            forScriptTxt = scriptOutput(list, gitHubUsername);
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return forScriptTxt;
    }
    public static void main(String args[]) throws NoSuchAlgorithmException {
        String cekSaya = generate("luthfiidrus");
        String cekSebela1 = generate("maisyrahmawati");
        String cekSebela2 = generate("marcelvaldhano");
        System.out.println(cekSaya);
        System.out.println(cekSebela1);
        System.out.println(cekSebela2);
    } 
} 
