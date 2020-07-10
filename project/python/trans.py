"""
@Author: Xim
@Date: 2020-07-07 16:06:08
@Description: 
@FilePath: \python\trans.py
"""
"""
@Author: Xim
@Date: 2020-07-07 16:06:08
@Description: 
@FilePath: \python\test\trans.py
"""
#! python
#
import os
import sys
import time

# Matplotlib.
import matplotlib.pyplot as plt

# PIL.
from PIL import Image

# Numpy.
import numpy as np

# OpenCV.
import cv2

# Skimage.
import skimage
from skimage import transform


# TODO: Resize.
dst_width, dst_height = 200, 200


# py_Resize.
def py_Resize(src, shape):
    # Shape.
    height, width, channels = src.shape
    dst_height, dst_width = shape
    dst_height = int(dst_height)
    dst_width = int(dst_width)
    if (dst_height == height) and (dst_width == width):
        return src
    # Object.
    dst_Image = np.zeros((dst_height, dst_width, channels), np.uint8)
    # Resize.
    # Scale for resize.
    scale_x = float(width) / dst_width
    scale_y = float(height) / dst_height
    # tmp
    for k in range(channels):
        for dst_y in range(dst_height):
            for dst_x in range(dst_width):
                # Original coords.
                src_x = (dst_x + 0.5) * scale_x - 0.5
                src_y = (dst_y + 0.5) * scale_y - 0.5
                # INTER_LINEAR:
                # 2*2 neighbors.
                src_x_0 = int(np.floor(src_x))
                src_y_0 = int(np.floor(src_y))
                src_x_1 = min(src_x_0 + 1, width - 1)
                src_y_1 = min(src_y_0 + 1, height - 1)
                #
                value0 = (src_x_1 - src_x) * src[src_y_0, src_x_0, k] + (
                    src_x - src_x_0
                ) * src[src_y_0, src_x_1, k]
                value1 = (src_x_1 - src_x) * src[src_y_1, src_x_0, k] + (
                    src_x - src_x_0
                ) * src[src_y_1, src_x_1, k]
                #
                dst_Image[dst_y, dst_x, k] = int(
                    (src_y_1 - src_y) * value0 + (src_y - src_y_0) * value1
                )
    return dst_Image


# Read the image.
# PIL.
# im = Image.open("test.bmp")
im = cv2.imread("test.bmp", cv2.IMREAD_COLOR)
(b, g, r) = cv2.split(im)
plt.figure(1)
plt.subplot(3, 1, 1)
plt.imshow(b)
plt.subplot(3, 1, 2)
plt.imshow(g)
plt.subplot(3, 1, 3)
plt.imshow(r)
print(im.size)
# (width, height): (1920, 1080)

# Numpy.
im_org = np.array(im)
print(im_org.shape)
# (height, width, channel): (1080, 1920, 3)

# 1. python.
_start = time.time()
imResize_py = py_Resize(im_org, (dst_width, dst_height))  # in 1
time1 = time.time() - _start
# Show ALL.
plt.figure(2)
plt.subplot(2, 1, 1)
plt.title("ORG")
plt.imshow(im_org)
plt.subplot(2, 1, 2)
plt.title("PY_resize: %fs" % (time1))
plt.imshow(imResize_py)
plt.show()
