clear;
close all;

datim = 1:500;
data = normrnd( 200, 20, size( datim ) );
data = abs( data );
xLimits = [0 501];
yLimits = [0 750];

data(199) = 500;
data(200) = 400;
data(201) = 700;
data(202) = 450;
data(401) = 700;


figure;
figure_size( 'l' );
tiledlayout( 'vertical' );

nexttile(1);
plot( datim, data, 'ko', 'MarkerFaceColor', 'r' );
xlim( xLimits );
ylim( yLimits );
title( 'Raw data')

nexttile(2);
data = movmean( data, 7 );
plot( datim, data, 'ko', 'MarkerFaceColor', 'r' );
xlim( xLimits );
ylim( yLimits );
title( '7-day moving mean' );

nexttile(3);
datac = cumsum( data-data(1) );
datab = downsample( datac, 7 );
dataa = diff( datab ) / 7;
data2 = [data(1) dataa+data(1) ];
datim2 = downsample( datim, 7 );
plot( datim2, data2, 'ko', 'MarkerFaceColor', 'r' );
xlim( xLimits );
ylim( yLimits );
title( '7-day mean' );


