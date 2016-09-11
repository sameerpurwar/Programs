from RGBhistogram import RGBHistogram
import argparse
import cPickle
import glob
import cv2
from Search import Searcher
import numpy as np

ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required = True,help = "Path to the directory that contains the images to be indexed")
ap.add_argument("-i", "--index", required = True,help = "Path to where the computed index will be stored")
args = vars(ap.parse_args())
index = {}

desc = RGBHistogram([8, 8, 8])

for imagePath in glob.glob(args["dataset"] + "\*.jpg"):
    k = imagePath[imagePath.rfind("\\") + 1:]
    print k
    image = cv2.imread(imagePath)
    features = desc.describe(image)
    index[k] = features

f = open(args["index"], "w")
f.write(cPickle.dumps(index))
f.close()



index = cPickle.loads(open(args["index"]).read())
searcher = Searcher(index)

for (query, queryFeatures) in index.items():
    result = searcher.search(queryFeatures)
    path = args["dataset"] + "\%s" % (query)
    queryImage = cv2.imread(path)
    cv2.imshow("Query", queryImage)
    cv2.waitKey(3000)
    print "query: %s" % (query)

    montageA = np.zeros((640,360*4,3), dtype = "uint8")
    montageB = np.zeros((640,360*4,3), dtype = "uint8")
    
    for j in range(8):
        (score, imageName) = result[j]
        path = args["dataset"] + "\%s" % (imageName)
        results = cv2.imread(path)
        print "\t%d. %s : %.3f" % (j + 1, imageName, score)
        
        
        if j < 4:
            montageA[:,j*360:(j + 1)*360,:] = results            
        else:
            montageB[:,(j - 4)*360:((j - 4) + 1)*360,:] = results
        
    cv2.imshow("Results 1-5", montageA)
    cv2.imshow("Results 6-10", montageB)
    cv2.waitKey(5000)
        