function [imhs, fig_h] = show_abundances(A2, m, n, title, plot_row, plot_col, options)
if nargin < 2
    if ndims(A2) == 3
        [m,n,M] = size(A2);
        A2 = reshape(A2, [m*n,M]);
    else
        return;
    end
end

if nargin < 4
    title = 'Abundances';
end

endmember_num = size(A2,2);
if nargin < 5 || plot_row == 0 || plot_col == 0
    row = floor(sqrt(endmember_num));
    col = ceil(endmember_num/row);
else
    row = plot_row;
    col = plot_col;
end

if nargin < 7
    options = [];
end

update = 0;
imhs = [];
fig_h = [];

if nargin > 5 && isstruct(options)
    arg_set = fieldnames(options);
    for i = 1:length(arg_set)
        eval([arg_set{i},'=options.',arg_set{i},';']);
    end
end


if 0
    figure;
    for i = 1:endmember_num
        subplot(row,col,i);
        I = reshape(A2(:,i),[m n]);
        imshow(I);
        xlabel(['(',char(96+i),') endmember ',num2str(i)]);
    end
    colormap(gca,'jet');
else
    if ~update
        fig_h = figure('name',title);
        for i = 1:endmember_num
            subtightplot(row,col,i);
            I = reshape(A2(:,i),[m n]);
            imhs(i) = imshow(I);
            colormap(gca,'jet');
        end
    else
        for i = 1:endmember_num
            I = reshape(A2(:,i),[m n]);
            set(imhs(i),'CData',I);
        end
    end


%     margin = round(0.05*min(m,n));
%     I = ones(row*m + (row-1)*margin, col*n + (col-1)*margin,3,'double');
%     for i = 1:endmember_num
%         r = ceil(i/col);
%         c = mod(i-1,col) + 1;
%         I1 = reshape(A2(:,i),[m n]);
%         I2 = ind2rgb(uint8(round(I1*255)),colormap('jet'));
%         start_r = (r-1)*m+1 + (r-1)*margin;
%         start_c = (c-1)*n+1 + (c-1)*margin;
%         I(start_r:start_r+m-1,start_c:start_c+n-1,:) = I2;
%     end
%     figure;
%     imshow(I);
end
