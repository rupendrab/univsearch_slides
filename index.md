---
title       : Find Universities by SAT Score
subtitle    : Using data publiched by College Scorecard
author      : Rupendra Bandyopadhyay
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

US Department of Education publishes data for US Universities that reveals SAT scores for 25th, 50th and 75th percentile of admitted students by institute. This data is available at the [College Scorecard Website.](https://collegescorecard.ed.gov/data)

Given this information, students should be able to find out which Universities typically admit students with scores close to theirs. Since we only have data for three discrete percentiles per University for each of the three SAT scores (reading, writing and math), we can only match a student to Universities given their preference of one of those specific percentiles of admitted students they would like to belong to.

So, an automated system would need the student to enter her SAT scores (for Reading, Writing and Math) and her preferred percentile rank (choice of 25, 50 or 75) by SAT scores in the institute where she would like to apply.

With this information it is possible determine the closeness of a college to a student by simply summing up the absolute differences between her scores and the universities' published scores. This closeness score can be used to display a list of matching institutes.



--- .class #id 

## Determine match and present results

--- 

## How it works (the core code)




```r
source("resources.R") # Source code for needed R functions
newData <- download_read_and_cleanse_scorecard_file()
satWrite <- 670; satRead <- 650; satMath <- 700; preferredPctRank <- 50; topn <- 20
ret <- getUnivMatches(satWrite, satMath, satRead, preferredPctRank, topn)
mychart <- ret("chartonly")
plot(ret("dataonly"))
```

<!-- Table generated in R 3.2.1 by googleVis 0.5.10 package -->
<!-- Sat Oct 24 12:59:13 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataTableID77567fce340 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Brandeis University",
"Waltham, MA",
600,
655,
710,
620,
670,
720,
630,
695,
760,
10,
90 
],
[
 "University of Rochester",
"Rochester, NY",
600,
650,
700,
620,
660,
700,
650,
700,
750,
10,
90 
],
[
 "Cooper Union for the Advancement of Science and Art",
"New York, NY",
610,
660,
710,
610,
670,
730,
610,
695,
780,
15,
85 
],
[
 "University of California-Berkeley",
"Berkeley, CA",
590,
655,
720,
620,
685,
750,
630,
700,
770,
20,
80 
],
[
 "Bryn Mawr College",
"Bryn Mawr, PA",
600,
655,
710,
620,
670,
720,
610,
685,
760,
20,
80 
],
[
 "Georgia Institute of Technology-Main Campus",
"Atlanta, GA",
600,
650,
700,
610,
655,
700,
660,
710,
760,
25,
75 
],
[
 "Emory University",
"Atlanta, GA",
620,
665,
710,
640,
685,
730,
650,
700,
750,
30,
70 
],
[
 "Case Western Reserve University",
"Cleveland, OH",
600,
660,
720,
620,
665,
710,
670,
715,
760,
30,
70 
],
[
 "Colby College",
"Waterville, ME",
620,
665,
710,
620,
670,
720,
640,
680,
720,
35,
65 
],
[
 "Boston College",
"Chestnut Hill, MA",
620,
665,
710,
640,
685,
730,
650,
695,
740,
35,
65 
],
[
 "University of Virginia-Main Campus",
"Charlottesville, VA",
620,
670,
720,
620,
670,
720,
630,
685,
740,
35,
65 
],
[
 "University of Michigan-Ann Arbor",
"Ann Arbor, MI",
620,
670,
720,
630,
680,
730,
660,
710,
760,
40,
60 
],
[
 "Northeastern University",
"Boston, MA",
640,
685,
730,
640,
680,
720,
660,
705,
750,
50,
50 
],
[
 "New York University",
"New York, NY",
620,
670,
720,
640,
685,
730,
630,
685,
740,
50,
50 
],
[
 "University of Southern California",
"Los Angeles, CA",
620,
670,
720,
640,
695,
750,
660,
710,
760,
55,
45 
],
[
 "Colorado College",
"Colorado Springs, CO",
610,
660,
710,
620,
660,
700,
610,
665,
720,
55,
45 
],
[
 "University of Miami",
"Coral Gables, FL",
600,
650,
700,
590,
640,
690,
630,
675,
720,
55,
45 
],
[
 "Tulane University of Louisiana",
"New Orleans, LA",
620,
660,
700,
630,
675,
720,
620,
660,
700,
55,
45 
],
[
 "Hamilton College",
"Clinton, NY",
640,
685,
730,
650,
690,
730,
660,
700,
740,
55,
45 
],
[
 "Occidental College",
"Los Angeles, CA",
600,
650,
700,
610,
655,
700,
610,
655,
700,
60,
40 
] 
];
data.addColumn('string','Institute');
data.addColumn('string','Location');
data.addColumn('number','Reading 25');
data.addColumn('number','Reading 50');
data.addColumn('number','Reading 75');
data.addColumn('number','Writing 25');
data.addColumn('number','Writing 50');
data.addColumn('number','Writing 75');
data.addColumn('number','Math 25');
data.addColumn('number','Math 50');
data.addColumn('number','Math 75');
data.addColumn('number','ScoreDifference');
data.addColumn('number','MatchScore');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartTableID77567fce340() {
var data = gvisDataTableID77567fce340();
var options = {};
options["allowHtml"] = true;
options["page"] = "enable";
options["height"] = "300";
options["frozenColumns"] =      2;

    var chart = new google.visualization.Table(
    document.getElementById('TableID77567fce340')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "table";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartTableID77567fce340);
})();
function displayChartTableID77567fce340() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartTableID77567fce340"></script>
 
<!-- divChart -->
  
<div id="TableID77567fce340" 
  style="width: 100%; height: 300;">
</div>

--- 

## And a Plot


```r
plot(mychart)
```

<!-- GeoChart generated in R 3.2.1 by googleVis 0.5.10 package -->
<!-- Sat Oct 24 12:57:10 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataGeoChartID775395cf99 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Waltham, MA",
"Brandeis University, Waltham, MA",
90 
],
[
 "Rochester, NY",
"University of Rochester, Rochester, NY",
90 
],
[
 "New York, NY",
"Cooper Union for the Advancement of Science and Art, New York, NY",
85 
],
[
 "Berkeley, CA",
"University of California-Berkeley, Berkeley, CA",
80 
],
[
 "Bryn Mawr, PA",
"Bryn Mawr College, Bryn Mawr, PA",
80 
],
[
 "Atlanta, GA",
"Georgia Institute of Technology-Main Campus, Atlanta, GA",
75 
],
[
 "Atlanta, GA",
"Emory University, Atlanta, GA",
70 
],
[
 "Cleveland, OH",
"Case Western Reserve University, Cleveland, OH",
70 
],
[
 "Waterville, ME",
"Colby College, Waterville, ME",
65 
],
[
 "Chestnut Hill, MA",
"Boston College, Chestnut Hill, MA",
65 
],
[
 "Charlottesville, VA",
"University of Virginia-Main Campus, Charlottesville, VA",
65 
],
[
 "Ann Arbor, MI",
"University of Michigan-Ann Arbor, Ann Arbor, MI",
60 
],
[
 "Boston, MA",
"Northeastern University, Boston, MA",
50 
],
[
 "New York, NY",
"New York University, New York, NY",
50 
],
[
 "Los Angeles, CA",
"University of Southern California, Los Angeles, CA",
45 
],
[
 "Colorado Springs, CO",
"Colorado College, Colorado Springs, CO",
45 
],
[
 "Coral Gables, FL",
"University of Miami, Coral Gables, FL",
45 
],
[
 "New Orleans, LA",
"Tulane University of Louisiana, New Orleans, LA",
45 
],
[
 "Clinton, NY",
"Hamilton College, Clinton, NY",
45 
],
[
 "Los Angeles, CA",
"Occidental College, Los Angeles, CA",
40 
] 
];
data.addColumn('string','Location');
data.addColumn('string','hint');
data.addColumn('number','MatchScore');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartGeoChartID775395cf99() {
var data = gvisDataGeoChartID775395cf99();
var options = {};
options["width"] =    800;
options["height"] =    350;
options["region"] = "US";
options["displayMode"] = "markers";
options["resolution"] = "metros";
options["backgroundColor"] = "lightblue";
options["enableRegionInteractivity"] = true;
options["colorAxis"] = {colors:['lightgreen', 'green', 'darkgreen']};

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID775395cf99')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID775395cf99);
})();
function displayChartGeoChartID775395cf99() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID775395cf99"></script>
 
<!-- divChart -->
  
<div id="GeoChartID775395cf99" 
  style="width: 800; height: 350;">
</div>
### Please visit the website at [https://rupenb.shinyapps.io/univsearch](https://rupenb.shinyapps.io/univsearch)
---

