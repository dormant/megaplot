load testBar.mat;

figure;
bar( datetimeSeis, dataSeis, 1.0, 'r' );
hold on;
bar( datetimeOLD, dataOLD, 1.0, 'k' );
xlim( [ datetime(1995,1,1) datetime(2000,1,1) ] );


