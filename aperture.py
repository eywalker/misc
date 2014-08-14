# -*- coding: utf-8 -*-
"""
Created on Sun Aug 10 22:01:52 2014

@author: eywalker
"""

import datajoint as dj

conn = dj.conn()
conn.bind(__name__, 'aperture_problem')

class Example(dj.Relvar):
    """
    aperture.Example (manual) # an example table
    -> aperture.Subjects
    id             :int unsigned       # unique subject identifier number
    -----
    phrase        :varchar(10)        # Initials of the subject
    power='N'      :ENUM('M','F','N')  # Gender of the subject, Male, Femlae, or Not-specified
    -> aperture.Exp1ShapeAxes
    """

class Subjects(dj.Relvar):
    """
    aperture.Subjects (manual) # my \
    newest table
    subject_id              :int unsigned       # unique subject identifier number
    -----
    subject_initials        :varchar(10)        # Initials of the subject
    subject_gender='N'      :ENUM('M','F','N')  # Gender of the subject, Male, Femlae, or Not-specified
    """

class Exp1Sets(dj.Relvar):
    """
    aperture.Exp1Sets (imported) # List of completed exp 1 sets
    -> aperture.Subjects
    """