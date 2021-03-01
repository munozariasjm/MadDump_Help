#!/usr/bin/env bash
#General configuration for the automatic spheno multi core configuration by brute force  23/03/2019
## Comments in order to make minimal implementations

workdir=$(pwd)
cd $workdir
tar -xzvf $workdir/tools/MG5_aMC_v2.6.4.tar.gz
tar -xzvf $workdir/tools/maddump_V1.0.2.tar.gz
ln -s MG5_aMC_v2_6_4 madgraph
unzip $workdir/tools/MesonFlux.zip
unzip $workdir/tools/DM_mesons_2.zip
unzip $workdir/tools/Darkphoton.zip
mv DM_mesons_2/ madgraph/models/
mv Darkphoton/ madgraph/models/
mv maddump/ madgraph/PLUGIN/

cp -r tools/core/mg5_configuration.txt  $workdir/madgraph/input/

cd $workdir/madgraph
cp -f ../tools/pion_decay_UFO .
cp -f ../MesonFlux/example_MesonFlux.hepmc .

newdir=$(pwd)
{
echo 'import model DM_mesons_2'
echo 'import_events decay example_MesonFlux.hepmc'
echo 'decay pi0 > y1 a, y1 > xd xd~'
echo 'define darkmatter xd'
echo 'add process interaction @DIS'
echo 'add process interaction @electron'
echo 'output DP_electron'
echo 'launch'
echo 'set flux_norm 2.0e20'
echo 'set prod_xsec_in_norm false '
echo 'set d_target_detector 5650.0'
echo 'set detector_density 3.72'
echo 'set Z_average 82'
echo 'set A_average 207'
echo 'set parallelepiped True'
echo 'set x_side 187.0'
echo 'set y_side 69.0'
echo 'set depth 200.0'
echo 'set ncores 16'
echo 'set testplot True'
echo 'set gvd11 -3.333333e-4'
echo 'set gvu11  6.666666e-4'
echo 'set gvd22 -3.333333e-4'
echo 'set gvu22  6.666666e-4'
echo 'set gvd33 -3.333333e-4'
echo 'set gvu33  6.666666e-4'
echo 'set gvl11 -1.000000e-3'
echo 'set gvl22 -1.000000e-3'
echo 'set gvl33 -1.000000e-3'
echo 'set my1 scan1:[0.01*i for i in range(1,2)]'
echo 'set mxd scan1:[0.01/3.*i for i in range(1,2)]'
echo 'set wy1 auto'
} > pion_decay_DP_try

./bin/mg5_aMC --mode=maddump pion_decay_DP_try

#echo "Example for maddump works properly. Now start our DP model"
#./bin/mg5_aMC --mode=maddump pion_decay_UFO
