
★ parse apache dir 
★ get list of all packages
★ instantiate objects

- parse PACKAGES

★ unpack first 50 → to_enum
    + unarchive tar.gz
  

- fill more info into objects
- persist data into db
- update data
- update task
    - handle versions
- tests
- sinatra app


===

to_enum


```
Package: zyp
Version: 0.10-1
Date: 2013-09-18
Title: Zhang + Yue-Pilon trends package
Author: David Bronaugh <bronaugh@uvic.ca>, Arelia Werner <wernera@uvic.ca> for the Pacific Climate Impacts Consortium
Maintainer: David Bronaugh <bronaugh@uvic.ca>
Depends: R (>= 2.4.0), Kendall
Suggests:
Description: The zyp package contains an efficient implementation of Sen's slope method (Sen, 1968) plus implementation of Xuebin Zhang's (Zhang, 1999) and Yue-Pilon's (Yue, 2002) prewhitening approaches to determining trends in climate data.
License: LGPL-2.1
URL: http://www.r-project.org
Packaged: 2013-09-18 20:28:20 UTC; bronaugh
NeedsCompilation: no
Repository: CRAN
Date/Publication: 2013-09-19 08:54:05
```

======

Versions

2 ways:

versions == array of all versions
versions == number of records in db
