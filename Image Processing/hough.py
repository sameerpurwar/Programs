import cv2
import numpy as np

def Hough(gray):
    
    circles = cv2.HoughCircles(gray,cv2.HOUGH_GRADIENT,1,20,param1=50,param2=30,minRadius=10,maxRadius=30)
    circles = np.uint16(np.around(circles))
    
    for i in circles[0,:]:
        # draw the outer circle
        cv2.circle(gray,(i[0],i[1]),i[2],(0,255,0),2)
        # draw the center of the circle
        cv2.circle(gray,(i[0],i[1]),2,(0,0,255),3)
    
    return gray