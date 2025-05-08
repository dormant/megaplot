#!/usr/bin/bash
#
# Run when triggered by webobs

cp /mnt/mvofls2/Seismic_Data/monitoring_data/megaplot3/configMegaplotWebobs.m .
sleep 10
rm /mnt/mvofls2/Seismic_Data/monitoring_data/megaplot3/configMegaplotWebobs.m


matlab -nodisplay -batch "plotMegaplot( 'webobs')" > /dev/null 2>&1
cp fig--megaplot3--webobs.png /mnt/mvofls2/Seismic_Data/monitoring_data/megaplot3/
