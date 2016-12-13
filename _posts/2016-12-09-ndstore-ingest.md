---
layout: post
title: ndstore ingest
description: "Learning how to ingest massive spatial volumes into the cloud at the tip of your fingers"
modified: 2016-12-09
category: tutorials
tags: [ndstore, data]
imagefeature: kasthuri11.jpg
comments: true
share: true
featured: true
---

# Ingesting 3D Data Volumes With Annotations in HDF5 Format to ndstore

In this tutorial we will show you how to take a 3D image volume and 3D annotation volume and: create a dataset, project, tokens and channels, ingest the data, and verify the process was successful.


### Step 1: Prepare your data

First ensure that your data is written to a properly formatted hdf5 volume. As an example, [this link](http://openconnecto.me/ocp/ca/kasthuri11/image/hdf5/3/1000,1300/2000,2200/1000,1200/) provides a 300x200x200 tiff image of electron microscopy data, and [this link](http://openconnecto.me/ocp/ca/kat11segments/annotation/hdf5/3/1000,1300/2000,2200/1000,1200/) provides annotations for the same region. Shown below are slices of this image:

![](http://openconnecto.me/ocp/ca/kasthuri11/image/xy/3/1000,1300/2000,2200/1100/)
![](http://openconnecto.me/ocp/ca/kat11segments/annotation/xy/3/1000,1300/2000,2200/1100/)

### Step 2: Interogating your data

In order to create a dataset, project, and channels for your data, you first need to understand several details of your data. Some of them can be found by interogating the images, while others require insight into the data acquisition (such as resolution, for instance).

The details which can be determined from your image are:

  - {x, y, z} image size
  - time range
  - data type
  - window range

The details which require information about your particular data are:

  - dataset name (no spaces or special characters)
  - {x, y, z} offset
  - scaling levels
  - scaling option
  - {x, y, z} voxel resolution

A description of each of these fields is available [here](http://docs.neurodata.io/ndstore/sphinx/datamodel.html#dataset-attributes).

In order to determine the details of interest from our data in HDF5 format, we will use Python's `h5py` library.


{% highlight python %}
import h5py
import numpy as np

filename = 'kasthuri11-image-hdf5-3-1000_1300-2000_2200-1000_1200-ocpcutout.h5'
with h5py.File(filename,'r') as hf:
    data = hf.get(hf.keys()[0])
    np_data = np.array(data.get('CUTOUT'))

print 'X image size: ', np_data.shape[0]
print 'Y image size: ', np_data.shape[1]
print 'Z image size: ', np_data.shape[2]
print 'Time series: ', (len(np_data.shape) == 4)
if (len(np_data.shape) == 4):
    print 'Time range: (%d, %d)' % (0, np.shape[3]-1)
else:
    print 'Time range: (0, 0)'
print 'Data type: ', np_data.dtype
print 'Window range: (%f, %f)' % (np.min(np_data), np.max(np_data))
{% endhighlight %}

X image size:  200<br/>
Y image size:  200<br/>
Z image size:  300<br/>
Time series:  False<br/>
Time range: (0, 0)<br/>
Data type:  uint8<br/>
Window range: (0.000000, 254.000000)
{: .notice}

Summarizing these results and those that must be determined with more intimate knowledge of the data, we come up with the following table:

|field | value|
|:----|:-----|
| dataset name | neurostorm_kat11_scale3 |
| x size | 200 |
| y size | 200 |
| z size | 300 |
| time range | (0, 0) |
| data type | uint8 |
| window range | (0, 254) |
| x offset | 1000 |
| y offset | 2000 |
| z offset | 1000 |
| scaling levels | 0 |
| scaling option | z-slices |
| x voxel resolution | 32 nm |
| y voxel resolution | 32 nm |
| z voxel resolution | 40 nm |

### Step 3:  Create A Dataset

Once you have this metadata about your images, you can begin the process of creating a dataset.

First, you should navigate to the server you wish to use (http://openconnecto.me/ocp/accounts/login/, for instance) and login (or register if you don't have an account). Once you enter your login information, you will be able to select the `Datasets > Create New Dataset` menu.

