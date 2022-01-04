% Manual setting for noise floor
noisefloor = 140;
% Specify table to be read
T = readtable('/Data/0_type3.csv');

% Variable declaration
peaks = [];
integralScaled = [];
unscaledIntegral = [];
symmetries = [];
% Extract names of original samples from the CSV file.
names = extractBetween(string(T.Properties.VariableDescriptions),"'", '_');


% Normal plot section
subplot(1,2,1)
hold on
grid on

for i=1: width(T)
    % Iterating through all columns
    col = T{:, i};
    plot(col, 'linewidth', 2);
    title('Samples at 0 degrees')
    xlabel('Time') 
    ylabel('Return Strength') 
    set(gca,'YTickLabel',[], 'XTickLabel', [])
    
    % Collect peak
    [peak, point] = max(col);
    % Append peak to peaks list
    peaks = [peaks peak];
    
    % Subtract noise floor
    col = col - noisefloor;
    for i=1:size(col)
       if col(i) <= 0
           % Set to 0 if point is below 0
           col(i) = 0;
       end
    end
    
    % Left integral is sum of all points from index 1 to point
    leftIntegral = sum(col(1:point));
    rightIntegral = sum(col(point:length(col)));
    
    % Symmetries are the integrals divided by each other
    symmetries = [symmetries leftIntegral/rightIntegral]; 
    
    % Unscaled integral is the raw integral
    unscaledIntegral = [unscaledIntegral sum(col)];
   
end
% Applying names.
legend(names);

% Optinal row for exporting high-res plot
% exportgraphics(gcf,'unscaled.png','Resolution',600)


% Scaled plots
subplot(1,2,2)
hold on
grid on
axis([0 1300 0 110])

for i=1: width(T)
    % Similar to prevoius
    col = T{:, i};
    % Scale factor derived from highest peak
    sf = 100 / max(col);
    % Apply scaled factor to each column
    col = col * sf;
    plot(col, 'linewidth', 2) 
    title('Samples at 0 degrees normalized')
    xlabel('Time') 
    ylabel('Return Strength') 
    ylabel('Return Strength') 
    set(gca,'YTickLabel',[], 'XTickLabel', []) 
    
    % Noise floor reduction with scale factor in mind
    col = col - noisefloor * sf;
    for i=1:size(col)
       if col(i) <= 0
           col(i) = 0;
       end
    end
    
    % Scaled integral is the sum of all scaled points
    integralScaled = [integralScaled sum(col)];
end
% Applying names
legend(names);

% Optinal row for exporting high-res plot
%exportgraphics(gcf,'scaled.png','Resolution',600)

% Displaying calculated numerics
disp("Names :");
disp(names);
disp("Peaks: ");
disp(peaks/10);
disp("Integral scaled: ");
disp(integralScaled/100);
disp("Symmetries: ");
disp(symmetries);
disp("Unscaled Integrals: ");
disp(unscaledIntegral);