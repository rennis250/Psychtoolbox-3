function retval = PR650init(portNumber)
% retval = PR650init(portNumber)
% 
% Initialize serial port for talking to colorimeter.
% Returns whatever character is sent by colorimeter
 
global g_serialPort;

% Only open if we haven't already.
if isempty(g_serialPort)
   SerialComm('open', portNumber, '9600,n,8,1');
   SerialComm('close', portNumber);
   WaitSecs(0.5);
   SerialComm('open', portNumber, '9600,n,8,1');
   g_serialPort = portNumber;
end

% Send set backlight command to high level to check
% whether we are talking to the meter.
SerialComm('write', portNumber, ['b3' char(10)]);
retval = [];
while isempty(retval)
    %retval = char(SerialComm('read', portNumber))';
    retval = PR650serialread;
end