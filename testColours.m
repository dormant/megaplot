clear;
close all;

col = {'r';'#48cae4';'#76c893';'k';'c'};
col = {'r','#48cae4','c'};
col = { '#ef476f', '#ffd166', '#06d6a0', '#118ab2', '#fb8500' };

randMult = 0.4;
X = 0:100;
Y = sin(X/10);
rng("default")
r1 = rand(size(X));
Y1 = Y + randMult*(r1-0.5);
r2 = rand(size(X));
Y2 = Y + randMult*(r2-0.5);
r3 = rand(size(X));
Y3 = Y + randMult*(r3-0.5);
r4 = rand(size(X));
Y4 = Y + randMult*(r4-0.5);
r5 = rand(size(X));
Y5 = Y + randMult*(r5-0.5);

markerSize = 6;

figure;
figure_size('p',1200);

tiledlayout('vertical');

for icol = 1:4
    switch icol
        case 1
            colBackground = 'w';
        case 2
            colBackground = [ .8 .8 .8 ];
        case 3
            colBackground = [211 222 174] / 255;
        case 4
            colBackground = [255 192 203] / 255;
    end

    nexttile();
    plot(X,Y1,'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col{1}, 'MarkerSize', markerSize );
    set(gca,'Color',colBackground);
    hold on;
    plot(X,Y2,'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col{2}, 'MarkerSize', markerSize );
    plot(X,Y3,'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col{3}, 'MarkerSize', markerSize );
    plot(X,Y4,'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col{4}, 'MarkerSize', markerSize );
    plot(X,Y5,'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col{5}, 'MarkerSize', markerSize );

end