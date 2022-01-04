% d=sequenze{1,1}(1,1);
% d0 = datetime(d,'ConvertFrom','excel')
% d=sequenze{1,1}(1,end);
% d0 = datetime(d,'ConvertFrom','excel')

% d={};
% for i=1:size(sequenze,1)
%     d=sequenze{i,1}(1,1);
%     d0 = datetime(d,'ConvertFrom','excel')
% end

function [d1,d2] =date_conversion(date1, date2)
    d1=datetime(date1,'ConvertFrom','excel');
    d2=datetime(date2,'ConvertFrom','excel');

% function [d0] =date_conversion(d)    
% %     d=data(1,a);
%     d0 = datetime(d,'ConvertFrom','excel');