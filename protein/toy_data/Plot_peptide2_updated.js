// !preview r2d3 data=c('MAAAAAAAAGDSDSWDADTFSMEDPVRKVAGGGTAGGDRWEGEDEDEDVKDNWDDDDDENKEEAEVKPEVKISEKKKIAEKIKEKERQQKKRQEEIKKRLEEPEESKVLTPEEQLADKLRLKKLQEESDLELAKETFGVNNTVYGIDAMNPSSRDDFTEFGKLLKDKITQYEKSLYYASFLEALVRDVCISLEIDDLKKITNSLTVLCSEKQKQEKQSKAKKKKKGVVPGGGLKATMKDDLADYGGYDGGYVQDYEDFM', 'AAAAAAAAGDSDSWDADTFSMEDPVRK', 'DDFTEFGK', 'GVVPGGGLK', 'ITNSLTVLCSEK', 'LEEPEESK', 'LQEESDLELAK', 'RLEEPEESK'), viewer = "browser"
//
  // r2d3: https://rstudio.github.io/r2d3
//
  
  
  //var ProteinSeq, AA, Peptides, data2;

//Protein sequence
var ProteinSeq = data[0];
var AA = ProteinSeq.split("");

//Peptide sequences
var peptide = [];
for (i = 1; i < data.length; i++) {
  peptide.push(data[i]);
}

var AA2 = [];
for (i = 0; i < AA.length; i++) {
  AA2.push({
    "AA": AA[i],
    "Index": i,
    "Match": "black"});
}

for (i = 0; i < peptide.length; i++) {
  var loc = ProteinSeq.search(peptide[i]);
  if (loc > 0) {
    for(j = loc; j < loc + peptide.length - 1; j++){
      AA2[j].Match = "blue";
    }
  }
}

// Scaling helpers.

var rowNum, colNum, chunkSize, spaceSize, maxWidth;

colNum = 10;
chunkSize = 10;
spaceSize = 5;
rowNum = Math.max(Math.ceil(ProteinSeq.length / (colNum * chunkSize)), 1);
maxWidth = colNum * (chunkSize + spaceSize);

function wrapx(i) {
  var i2 = i + Math.floor(i/chunkSize) * spaceSize;
  if(i2 >= maxWidth) {
    i2 = i2 % maxWidth;
  }
  return i2;
}

var scalex = d3.scaleLinear()
.domain([0, maxWidth])
.range([0, width]);

var scaley = d3.scaleLinear()
.domain([0, rowNum])
.range([height* 0.1, height * 0.9]);

// 
  
  
  //Actual plotting of the data.
var seq = svg.selectAll('g')
.data(AA2, function (d) { return d.Index;});


var seq2 = seq.enter().append('text')
.attr('x', function (d, i) { return scalex(wrapx(i));})
.attr('y', function (d, i) { return scaley(Math.floor(i / (colNum * chunkSize)));})
.text(function(d, i) { return d.AA; })
.attr("fill", function(d, i) { return d.Match})
.attr('font-size', "10px");


//document.getElementById("text1").innerHTML = "TESTING!";






seq2.on("mouseover", function() {
  var a = d3.select(this);
  var a2 = a.attr('font-size');
  var a3 = a.attr('fill');
  a.transition()
  .duration(1000)
  .attr('fill', 'red')
  .style('font-size', "40px");
  
  a.transition()
  .delay(2000)
  .duration(1000)
  .attr('fill', a3)
  .style('font-size', a2);
});