function [message] = decrypt(msgFile,keyFile)

%import values from file

%msgFile = 'testFile.txt'
%keyFile = 'testKey..txt'

fid1 = fopen(msgFile,'r');
fid2 = fopen(keyFile','r');

crypTrix  = fscanf(fid1,'%x');
masterKey = fscanf(fid2,'%x');

%assign to properly formed matrices

messLen= length(crypTrix);
masterKeyLen = length(masterKey);
chunks = floor(messLen/100);

crypTrixP = zeros(10*chunks,10);
masterKeyP= zeros(10*chunks,20);

%place elements into their properly formed matrices.

for n = 1:messLen;

	crypTrixP(n) = crypTrix(n);
end

for n = 1:masterKeyLen;

	masterKeyP(n) = masterKey(n);
end

%break up the key into the screen and key

screenTrix = zeros(10*chunks,10);
keyTrix    = zeros(10*chunks,10);
 
for n = 1:masterKeyLen/2;

	screenTrix(n) = masterKeyP(n+(n-1));
end

for n = 1:masterKeyLen/2;

	keyTrix(n)= masterKeyP(n*2);
end

%run the encrypted matrix through the screen and key

for n = 1:masterKeyLen/2;

	indexed(n) = crypTrixP(keyTrix(n));
end

for n = 1:masterKeyLen/2;

	screened(n) = indexed(n) / screenTrix(n);
end

%isolate characters 

characters = zeros(chunks,80);

for n = 1:chunks;

	characters(n,:) = screened(1+(100*(n-1)):80+(100*(n-1)));
end

%parse character matrix into the final message

charRows = length(characters(:,1));

for n = 1:charRows;

	message(1+((n-1)*80):80+((n-1)*80)) = characters(n,:);
end

fprintf('\n');
fprintf('%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c',message);
fprintf('\n');

%demonstration switch
if 0
disp('message')
disp(char(message'))
disp('masterKey')
disp(masterKeyP)
disp('crypTrixP')
disp(crypTrixP)
disp('screenTrix')
disp(screenTrix)
disp('keyTrix')
disp(keyTrix)
%demonstration switchlet
end
