clear, clc

delete(instrfind({'Port'},{'/dev/ttyACM0'}));
serialx = serial('/dev/ttyACM0', 'BaudRate', 9600);
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

fopen(serialx)

x = 0;

while (x < 100)
    
    fscanf(serialx);
    x = x + 1;
end

fclose(serialx)


