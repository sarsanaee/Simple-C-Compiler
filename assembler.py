import sys

temp = -1
templist = []

with open(sys.argv[1], "r") as f :
    for line in f:
        line = line.split()
        if(len(line) == 6 and line[3] == '+'):
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= add i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= add i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= add i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= add i32 " ,'% ', line[2] , ', %',line[4]
           #
           #
           #print line[0],"= add i32" , line[2] , ', %',line[4]
             
        elif(len(line) == 6 and line[3] == '*'):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= mul i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= mul i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= mul i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= mul i32 " ,'% ', line[2] , ', %',line[4]
        
        elif(len(line) == 6 and line[3] == '/'):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= udiv i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= udiv i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= udiv i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= udiv i32 " ,'% ', line[2] , ', %',line[4]
        
        elif(len(line) == 4 ):
               if(line[2].isdigit()):
                   print "%",line[0],"=" , line[2]
               else :
                    print "%",line[0],"= " ,'% ', line[2]
                    
                    
        elif(len(line) == 6 and line[3] == '='):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= icmp eq i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= icmp eq  i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= icmp eq i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= icmp eq i32 " ,'% ', line[2] , ', %',line[4]
       
        elif(len(line) == 6 and line[3] == '!='):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= icmp ne i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= icmp ne  i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= icmp ne i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= icmp ne i32 " ,'% ', line[2] , ', %',line[4]

        elif(len(line) == 6 and line[3] == '>'):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= icmp sgt i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= icmp sgt  i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= icmp sgt i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= icmp sgt i32 " ,'% ', line[2] , ', %',line[4]

        elif(len(line) == 6 and line[3] == '>='):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= icmp sge i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= icmp sge  i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= icmp sge i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= icmp sge i32 " ,'% ', line[2] , ', %',line[4]
         
        elif(len(line) == 6 and line[3] == '<'):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= icmp slt i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= icmp slt  i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= icmp slt i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= icmp slt i32 " ,'% ', line[2] , ', %',line[4]

        elif(len(line) == 6 and line[3] == '<='):
           
           if(line[2].isdigit() and not line[4].isdigit() ):
               print "%",line[0],"= icmp sle i32" , line[2] , ', %',line[4]
           elif(line[4].isdigit() and not line[2].isdigit()):
               print "%",line[0],"= icmp sle i32" , ' %' ,line[2] ,',', line[4]
           elif(line[4].isdigit() and line[2].isdigit()):
               print "%",line[0],"= icmp sle i32" , line[2] ,' ,', line[4]
           else:
               print "%",line[0],"= icmp sle i32 " ,'% ', line[2] , ', %',line[4] 
       
        elif(line[0] == 'if'):
           temp = temp + 1
           templist.append("l" + str(temp)) 
           print "br il" , line[2] ,"label", "%" + templist[-1], "label %" + line[4] , "\n" , templist[-1] + ":" 
            
        elif(len(line) == 2 and line[1] == ':'):
           print line[0] + ":"
        
        elif(line[0] == "goto" ):
           print "jmp " + line[1] 
           
        elif(line[2] == "(" and line[4] == ")"):
           print "%" + line[0] + "= %" + line[3] 
           
f.close()
