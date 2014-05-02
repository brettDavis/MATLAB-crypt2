function [encryptedMessage masterKey] = encrypt(fileName,keyName,message)

%vars

messLen =  length(message);

%determine the number of chunks

if mod(messLen,80) == 0;

	chunks = floor(messLen/80);  
else
	chunks = floor(messLen/80) + 1;
end

%break up input vectors into length 80 segments, and place them in a
% holding matrix:  holdingTrix

holdingTrix = zeros(chunks,80);
cabooseLen  = rem(messLen,80);

for n = 1:chunks;

        if chunks - n == 0;
 
                holdingTrix(n,1:cabooseLen) = message(((n-1)*80)+1:((n-1)*80)+cabooseLen);
        else
                holdingTrix(n,1:80) = message(((n-1)*80)+1:((n-1)*80)+80);
        end
end

disp('holdingTrix');
disp(char(holdingTrix));

	
%set up initial matrix scaffold

messTrix = zeros(10*chunks,10);

% Assign values to main matrix from holding matrix and salt with random unicode vals
% First 80 values in chunk = message
% last  20 values in chunk = salt

for n = 1:chunks;
	
	messTrix(1+(100*(n-1)):80+(100*(n-1)))   = holdingTrix(n,:);
	rng(1) 
	messTrix(81+(100*(n-1)):100+(100*(n-1))) = randi([41 122],1,20);
end

%Assemble the screen and the index key
screenTrix = zeros(10*chunks,10);
keyTrix    = zeros(10*chunks,10);

%The screen is a random number that the index will be multiplied by
for n = 1:(chunks*100);

	rng(n);
	screenTrix(n) = randi([2 33]);
end

%They key contains the index value of the final matrix that the elements of 
%messTrix will be moved to

b     = 1:(100*chunks);
keyVec= b(randperm(length(b)));

for n = 1:(chunks*100);

	keyTrix(n) = keyVec(n);
end

%pass the elements of messTrix through the screen and key into the final matrix

encryptedMessage = zeros(chunks*10,10);

for n = 1:(100*chunks);

	encryptedMessage(keyTrix(n)) = screenTrix(n) .* messTrix(n);
end

%place the screen and key into a single matrix

masterKey = zeros(10*chunks,20);

for n = 1:(numel(screenTrix)+numel(keyTrix));

	if mod(n,2) == 0;

		masterKey(n) = keyTrix(n-(n/2));

	else;

		masterKey(n) = screenTrix(n-floor(n/2));
	end;
end

%writing switch
if 1
%write to file
%fileName  = 'testFile1.txt'
%keyName   = 'testKey1.txt'

outFile   = fopen(fileName,'w');
keyFile   = fopen(keyName,'w');

fprintf(outFile,'%x %x %x %x %x %x %x %x %x %x \n',encryptedMessage);
fprintf(keyFile,'%x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x \n',masterKey);

fprintf('\n|<<:|<*!WRITE SUCCESSFUL!*>|:>> \n\n')


%They key contains the index value of the final matrix that the elements of 
%writing switchlet
end

%demonstration switch
if 0

disp('messTrix')
disp(messTrix)
disp(char(messTrix))
disp('screenTrix')
disp(screenTrix)
disp('keyTrix')
disp(keyTrix)
disp('encryptedMessage')
disp(encryptedMessage)
disp('masterKey')
disp(masterKey)
%demonstration switchlet
end





