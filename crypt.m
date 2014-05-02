%%The Crypt is a matrix based encryption program. 
fprintf('\n          ________________         ')
fprintf('\n         :|     |   |     |:       ')
fprintf('\n        |:| THE CRYPT 2.0 |:|      ')
fprintf('\n      [||:|_____|___|_____|:||]    ')
fprintf('\n          =====/////======         ')
fprintf('\n          ====////========         ')
fprintf('\n          ===//===========         ')
fprintf('\n                                   ')
fprintf('\n 1) Encrypt 2) Decrypt\n')

choice = input('\n Which is your choice?  >>>  ');


if choice == 1
	
	fprintf('\n\n      [||:|_ENCRYPT_|:||]\n\n')
		
	fileName    = input('\n FILENAME://:>  ','s');
	
	keyName     = input('\n KEYNAME:///:>  ','s');	
	
	message     = input('\n MESSAGE:///:>  ','s');	

	encrypt(fileName,keyName,message);

elseif choice == 2
	
	fprintf('\n\n       [||:|_DECRYPT_|:||]\n\n')
	
	msgFile  = input('\n FILE://:>  ','s');
	
	keyFile      = input('\n KEY:///:>  ','s');
	
	decrypt(msgFile,keyFile);
	
else

	fprintf('pick a real choice ya dingus!')
	break
end





