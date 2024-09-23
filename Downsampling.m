function output = Downsampling(filename)
%IMPORTFILE �ؽ�Ʈ ������ ������ �����͸� ��ķ� �����ɴϴ�.
%   SUC1465 = IMPORTFILE(FILENAME) ����Ʈ ���� �׸��� �ؽ�Ʈ ���� FILENAME���� �����͸� �н��ϴ�.
%
%   SUC1465 = IMPORTFILE(FILENAME, STARTROW, ENDROW) �ؽ�Ʈ ���� FILENAME��
%   STARTROW �࿡�� ENDROW ����� �����͸� �н��ϴ�.
%
% Example:
%   Suc1465 = importfile('Suc1_465.csv', 1, 4104);
%
%    TEXTSCAN�� �����Ͻʽÿ�.

% MATLAB���� ���� ��¥�� �ڵ� ������: 2018/10/08 10:37:26

%% ������ �ʱ�ȭ�մϴ�.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% ������ ���� �ؽ�Ʈ�� ����:
% �ڼ��� ������ ���� �������� TEXTSCAN�� �����Ͻʽÿ�.
formatSpec = '%*q%*q%q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%*q%*q%*q%*q%*q%*q%*q%q%[^\n\r]';

%% �ؽ�Ʈ ������ ���ϴ�.
fileID = fopen(filename,'r');

%% ���Ŀ� ���� ������ ���� �н��ϴ�.
% �� ȣ���� �� �ڵ带 �����ϴ� �� ���Ǵ� ������ ����ü�� ������� �մϴ�. �ٸ� ���Ͽ� ���� ������ �߻��ϴ� ��� �������� ������
% �ڵ带 �ٽ� �����Ͻʽÿ�.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% �ؽ�Ʈ ������ �ݽ��ϴ�.
fclose(fileID);

%% ������ �ؽ�Ʈ�� �ִ� ���� ������ ���ڷ� ��ȯ�մϴ�.
% �������� �ƴ� �ؽ�Ʈ�� NaN���� �ٲߴϴ�.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    % �Է� ���� �迭�� �ؽ�Ʈ�� ���ڷ� ��ȯ�մϴ�. �������� �ƴ� �ؽ�Ʈ�� NaN���� �ٲ���ϴ�.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % �������� �ƴ� ���λ� �� ���̻縦 �˻��ϰ� �����ϴ� ���� ǥ������ ����ϴ�.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % õ ������ �ƴ� ��ġ���� ��ǥ�� �˻��߽��ϴ�.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % ������ �ؽ�Ʈ�� ���ڷ� ��ȯ�մϴ�.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% �������� �ƴ� ���� �������� �ٲٱ�: NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % �������� �ƴ� �� ã��
raw(R) = {NaN}; % �������� �ƴ� �� �ٲٱ�

%% ��� ���� �����
DS1 = table;
DS1.TIME = cell2mat(raw(:, 1));
DS1.D0 = cell2mat(raw(:, 2));
DS1.D8 = cell2mat(raw(:, 3));
DS1.D16 = cell2mat(raw(:, 4));
DS1.D24 = cell2mat(raw(:, 5));
DS1.D32 = cell2mat(raw(:, 6));
DS1.D40 = cell2mat(raw(:, 7));
DS1.D48 = cell2mat(raw(:, 8));
DS1.D56 = cell2mat(raw(:, 9));
DS1.D64 = cell2mat(raw(:, 10));
DS1.D72 = cell2mat(raw(:, 11));
DS1.D80 = cell2mat(raw(:, 12));
DS1.D88 = cell2mat(raw(:, 13));
DS1.D96 = cell2mat(raw(:, 14));
DS1.D104 = cell2mat(raw(:, 15));
DS1.D112 = cell2mat(raw(:, 16));
DS1.D120 = cell2mat(raw(:, 17));
%% Table to array
DS1_mat=table2array(DS1);
%% ������
output=[];
for n=2:1:(size(DS1_mat,1)-1);
    for m=1:1:15;
    output((n-2)*15+m,1)=DS1_mat(n,1)+(DS1_mat(n+1,1)-DS1_mat(n,1))/16*(m-1);
    output((n-2)*15+m,2)=DS1_mat(n,m+1);
    end
end
