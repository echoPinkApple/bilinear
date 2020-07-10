"""
@Author: Xim
@Date: 2020-07-09 09:16:40
@Description: 
@FilePath: \python\merge.py
"""

import cv2
import numpy as np


def read_data(str, size):
    lnum = 0
    img = np.zeros((size, size), np.uint8)
    with open(str, "r") as data:
        for line in data:
            if lnum < size * size:
                i = (int(lnum / size)) % size
                j = int((lnum + size - 10) % size)
                img[i, j] = int(line.strip("\n"), 16)
            lnum += 1
        data.close()
    return img


def merging(data_R, data_G, data_B):
    mergedImage = cv2.merge([data_B, data_G, data_R])
    print(mergedImage.shape)
    # cv.imshow("mergedImage", mergedImage)
    return mergedImage


str_R = "./savedata_R.txt"
str_G = "./savedata_G.txt"
str_B = "./savedata_B.txt"
size = 256
data_R = read_data(str_R, size)
data_G = read_data(str_G, size)
data_B = read_data(str_B, size)
data_RGB = merging(data_R, data_G, data_B)
cv2.imwrite("./result_R.jpg", data_R)
cv2.imwrite("./result_G.jpg", data_G)
cv2.imwrite("./result_B.jpg", data_B)
cv2.imwrite("./result_RGB.jpg", data_RGB)
cv2.imshow("img", data_RGB)
cv2.waitKey(0)
cv2.destroyAllWindows()
