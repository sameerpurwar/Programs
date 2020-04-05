import cv2
import numpy as np
import matplotlib.pyplot as plt

rgb = cv2.imread('image2.png')
X = np.shape(rgb)[1]
Y = np.shape(rgb)[0]

small = cv2.cvtColor(rgb, cv2.COLOR_BGR2GRAY)

kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3))

grad = cv2.morphologyEx(small, cv2.MORPH_GRADIENT, kernel)

_, bw = cv2.threshold(grad, 0.0, 255.0, cv2.THRESH_BINARY | cv2.THRESH_OTSU)

kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (9,1))

connected = cv2.morphologyEx(bw, cv2.MORPH_CLOSE, kernel)

# can use RETR_EXTERNAL, RETR_CCOMP & RETR_LIST
_, contours, hierarchy = cv2.findContours(connected, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)

mask = np.zeros(bw.shape, dtype=np.uint8)
fmask = np.zeros(bw.shape, dtype=np.uint8)
#fig = plt.figure()
#ax = fig.add_subplot(111)
#ax.set_title('MASK')

for idx in range(len(contours)):
    x, y, w, h = cv2.boundingRect(contours[idx])
    mask[y:y+h, x:x+w] = 0
    cv2.drawContours(mask, contours, idx, 255, -1)
    #plt.imshow(mask)
    #plt.show()

    r = float(cv2.countNonZero(mask[y:y+h, x:x+w])) / (w * h)
    # print(idx,w/h,r)
    if r > 0.4 and w > 8 and h > 6 and w < 400:
        cv2.rectangle(mask, (x, y), (x+w-1, y+h-1), (146,255,255), 1)
        cv2.drawContours(fmask, contours, idx, 255, -1)
        
dst = cv2.inpaint(rgb,fmask,3,cv2.INPAINT_TELEA)
plt.imshow(dst)
plt.show()

cv2.imwrite("IMAGE2.png",dst) # Saving image
#%% Testing & Debugging
'''
mask = np.zeros(bw.shape, dtype=np.uint8)
fmask = np.zeros(bw.shape, dtype=np.uint8)

for idx in range(len(contours)):
    x, y, w, h = cv2.boundingRect(contours[idx])
    mask[:,:] = 0 # mask[y:y+h, x:x+w] = 0 (or use this)
    cv2.drawContours(mask, contours, idx, 255, -1)
    r = float(cv2.countNonZero(mask[y:y+h, x:x+w])) / (w * h)
    cv2.rectangle(mask, (x, y), (x+w-1, y+h-1), (146,255,255), 1)
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.set_title('MASK'+str(idx))
    ax.imshow(mask)
    print(idx,r,w,h)
    if r > 0.4 and w > 8 and h > 6 and w < 400:
        cv2.rectangle(mask, (x, y), (x+w-1, y+h-1), (146,255,255), 1)
        cv2.drawContours(fmask, contours, idx, 255, -1)
plt.imshow(fmask)
'''
#%%




















    
    
    
    
    
    
    
    
    
    
    
    plt.show()
