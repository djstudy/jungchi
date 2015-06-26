# -*- coding: utf-8 -*-
import urllib2
import csv
import re
from VoteResult import VoteResult
chong = '총 [0-9]{3}'
chansung = '찬성 [0-9]+'
bandae = '반대 [0-9]+'
gigwon = '기권 [0-9]+'
boolcham = '불참 [0-9]+'
chooljang = '출장 [0-9]+'
cheongga = '청가 [0-9]+'
gyulseok = '결석 [0-9]+'
vote_categories = [chong, chansung, bandae, gigwon, boolcham, chooljang, cheongga, gyulseok]

chansung_list = "<TD VALIGN=TOP NOWRAP>찬성"
bandae_list  = "<TD VALIGN=TOP NOWRAP>반대"
gigwon_list  = "<TD VALIGN=TOP NOWRAP>기권"
boolcham_list = "<TD VALIGN=TOP NOWRAP>불참"
chooljang_list = "<TD VALIGN=TOP NOWRAP>출장"
cheongga_list = "<TD VALIGN=TOP NOWRAP>청가"
gyulseok_list = "<TD VALIGN=TOP NOWRAP>결석"

vote_list = [chansung_list, bandae_list, gigwon_list, boolcham_list, chooljang_list, cheongga_list, gyulseok_list]

def get_list(html, desired_index, vote_list):
    if len(vote_list) <= desired_index:
        return ""
    splitted = html.split(vote_list[desired_index])
    if len(splitted) < 2:
        return ""
        # Here we have no result
    partial_result = splitted[1]
    for i in range(desired_index+1, len(vote_list)):
        splitted2 = partial_result.split(vote_list[i])
        if len(splitted2) < 2:
            continue
        else:
            return splitted2[0]
    return partial_result

def get_numbers(list_html, congressman_set):
    result_row = ""
    list_of_address = re.findall(r"/New/cm_info.php\?member_seq=[0-9]+", list_html)
    for address in list_of_address:
        number = re.search("[0-9]{1,3}", str(address))
        if number:
            result_row = result_row + ";" + number.group(0)
            congressman_set.add(number.group(0))
        else:
            print "error?"

    return result_row

base_address = 'http://watch.peoplepower21.org/New/c_monitor_voteresult_detail.php?mbill='
congressman_set = set([])

""" first upload was 6989 """
""" last  upload was 9215 """
f = open("vote_results.csv", 'w')
f.write("voted_date,v_id,v_title,chansung,bandae,gigwon,boolcham,chooljang,cheongga,gyulseok,chansung_list,bandae_list,gigwon_list,boolcham_list,chooljang_list,cheongga_list,gyulseok_list\n")

for index in range(6989, 9215):
    address = base_address + str(index)
    response = urllib2.urlopen(address)
    html = response.read()

    result_row = ""


    result = re.search('[0-9]+-[0-9]+-[0-9]+', html)
    if result:
        result_row =  result.group(0)
    else:
        continue
    result_row = result_row + ", " + str(index)
    result = re.search('<B>(.*)</B>', html)
    if result:
        result_row = result_row + ", " + result.group(1).replace(",", ".")

    vote_result = ""
    for category in vote_categories:
        result = re.search(category, html)
        if result:
            result_row = result_row + ", " + result.group(0)[6:]
        else:
            result_row = result_row + ", 0" 

    vote_result_row = ""
    result_list = []
    for i in range(0, len(vote_list)):
        numbers = get_numbers(get_list(html,i,vote_list), congressman_set)
        if numbers != "":
            result_list.append(get_numbers(get_list(html,i,vote_list), congressman_set))
        else:
            result_list.append("")
    for each_result in result_list:
         vote_result_row = vote_result_row + ", " + each_result
    to_be_written = result_row + ", " + vote_result_row + "\n"
    f.write(to_be_written)
    #print to_be_written
f.close()


f = open("representatives.csv", 'w')
f.write("id,name,email,party,area,combo\n")

cman_pic_address = "http://watch.peoplepower21.org/images/member/"
cman_head_address = 'http://watch.peoplepower21.org/New/cm_info.php?member_seq=' 
cman_tail_address = "&from=c_monitor_voteresult_detail.php"
cman_name_pattern = """<td VALIGN=TOP><span style="font-size:12px; font-family:Gulim;font-weight:bold; letter-spacing:-1px; color:#4686BE; text-decoration:none;">(.*)</span><span class="""
cman_info_pattern = """<td colspan="2" ><b  style="font-size:12px; font-family:Gulim;font-weight:bold; letter-spacing:-1px;">(.*)</b></td></tr>"""
cman_mail_pattern = "mailto:(.*)\""
for man_id in congressman_set:
    result_row = ""
    address = cman_head_address + str(man_id) + cman_tail_address
    response = urllib2.urlopen(address)
    html = response.read()
    info_result = re.search(cman_info_pattern,html)
    name_result = re.search(cman_name_pattern,html)
    mail_result = re.search(cman_mail_pattern,html)
    if name_result:
        result_row = str(man_id) + ", " + name_result.group(1)
    else:
        result_row = str(man_id) + ", 0"
        continue
    if mail_result and len(mail_result.group(1)) > 0:
        result_row = result_row + ", " + mail_result.group(1)
    else:
        result_row = result_row + ", 0"
    if info_result:
        splitted_info = info_result.group(1).split("/")
        if len(splitted_info) == 1:
          result_row = result_row + ", " + info_result.group(1) + ", 0, 0 " 
        else:
          c = 0
          for each_info in splitted_info:
              c = c + 1
              if c == 3:
                result_row = result_row + ", " + each_info[:1]
              else:
                result_row = result_row + ", " + each_info

    result_row = result_row +  "\n"
    print result_row
    f.write(result_row)
f.close()



