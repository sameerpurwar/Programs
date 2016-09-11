import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('integers', metavar='N', type=int, nargs='+',
                    help='an integer for the accumulator')
parser.add_argument('--sum', dest='accumulate', action='store_const',
                    const=sum, default=max,
                    help='sum the integers (default: find the max)')

args = parser.parse_args()
print args
##

ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required = True,help = "Path to the directory that contains the images to be indexed")
ap.add_argument("-i", "--index", required = True,help = "Path to where the computed index will be stored")
args = vars(ap.parse_args())