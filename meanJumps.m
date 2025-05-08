function [datetimeData, dataData] = meanJumps( datetimeData, dataData, tJump, datetimeBeg, datetimeEnd )

    if ~exist('datetimeBeg','var')
        datetimeBeg = datetimeData(1);
        datetimeEnd = datetimeData(end);
    end

    datetimeData2 = datetime([],[],[]);
    dataData2 = [];

    while datetimeBeg < datetimeEnd

        datetimeJump = datetimeBeg + days( tJump );

        idWant = datetimeData >= datetimeBeg & datetimeData < datetimeJump;
        datetimeData2(end+1) = mean( datetimeData(idWant), 'omitnan' );
        dataData2(end+1) = mean( dataData(idWant), 'omitnan' );

        datetimeBeg = datetimeJump;

    end

    datetimeData = datetimeData2;
    dataData = dataData2;

end
