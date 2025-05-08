#!/usr/bin/bash
#
# Run under cron to create megaplots for webobs

matlab -nodisplay -batch "plotMegaplot( 'configLastFiveYears.m')" > /dev/null 2>&1
matlab -nodisplay -batch "plotMegaplot( 'configLastSixMonths.m')" > /dev/null 2>&1
matlab -nodisplay -batch "plotMegaplot( 'configLastTwoYears.m')" > /dev/null 2>&1
matlab -nodisplay -batch "plotMegaplot( 'configLastYear.m')" > /dev/null 2>&1
matlab -nodisplay -batch "plotMegaplot( 'configPause5.m')" > /dev/null 2>&1
matlab -nodisplay -batch "plotMegaplot( 'configWholeEruption.m')" > /dev/null 2>&1
cp fig--megaplot3--last*.png /mnt/mvofls2/Seismic_Data/monitoring_data/megaplot3/
cp fig--megaplot3--pause5.png /mnt/mvofls2/Seismic_Data/monitoring_data/megaplot3/
cp fig--megaplot3--wholeEruption.png /mnt/mvofls2/Seismic_Data/monitoring_data/megaplot3/
