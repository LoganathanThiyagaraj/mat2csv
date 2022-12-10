clc
 [Filename Filepath]=uigetfile('*.mat','Please select .MAT file');
 matData=load(Filename);
 No_of_Testcases=size(matData.sldvData.TestCases);
array=([0]);
finalarray=([0]);
csvfile = 'mattocsv.xls';
sheet = 'Sheet1';
count=0;
 [Filename1 Filepath2]=uigetfile('*.slx','Please select .slx file');
addpath(genpath(Filepath2))

modelname=regexprep(Filename1,'.slx','');
%  cd(Filepath2)
load_system(modelname);
port_list = find_system(modelname,'SearchDepth',1,'BlockType','Inport');
inport_name={[0]};
for ii=1:length(port_list)
    inport_name{ii}=port_list{ii};
    inport_name{ii}=char(extractAfter(inport_name{ii},'/'));
end
inport_name{ii+1}='t';
% inport_name=convertCharsToStrings(inport_name);
% cd Filepath
for i=1:No_of_Testcases(2)
    array=([0]);
   No_of_Data=size(matData.sldvData.TestCases(i).dataValues);
   for j=1:No_of_Data(1)
       DataValues=matData.sldvData.TestCases(i).dataValues{j,1};
          Data=DataValues;
          Data=Data.';
       size_of_Data=size(Data);
       for k=1:size_of_Data(1)
           array(k,j)=(Data(k,1));            
       end  
       
   end
   count=count+k;
   timevalue=matData.sldvData.TestCases(i).timeValues;
   timevalue=timevalue.';
   array=horzcat(array,timevalue);
   if i==1
     
       csvfilename=[modelname '.csv'];
      
       
% dlmwrite(sprintf(csvfilename),inport_name,'delimiter',',','-append');       
csvwrite(sprintf(csvfilename),array,1,0); 
dlmwrite(sprintf(csvfilename),' ','delimiter',',','-append');
    
   else

      dlmwrite(sprintf(csvfilename),array,'delimiter',',','-append');
      dlmwrite(sprintf(csvfilename),' ','delimiter',',','-append');

%  dlmwrite('mattocsv1.csv',array,count+1-k,0,'-append');     
%        finalarray=vertcat(finalarray,array);    
   
   end
end
 xlswrite(csvfilename,inport_name,modelname,'A1');