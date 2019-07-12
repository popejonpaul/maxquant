// !preview r2d3 data=read.csv("Peptide.csv"), viewer = "browser"
//
// r2d3: https://rstudio.github.io/r2d3
//


var colNum = 5;

var rowNum = Math.ceil(data.length / colNum);



var scalex = d3.scaleLinear()
.domain([0, colNum])
.range([0, width]);

var scaley = d3.scaleLinear()
.domain([0, rowNum])
.range([0, height]);



var seq = svg.selectAll('text')
  .data(data, function (d) { return d.Chunk;})
  .enter().append('text');
  
seq.attr('x', function (d, i) { return scalex((d.Chunk - 1) % colNum);})
   .attr('y', function (d, i) { return scaley(Math.floor((d.Chunk - 1) / colNum));})
   .text(function(d) { return d.Sequence; })
   .attr('font-size', "20px");
   

seq.exit().remove();
  
  
  
seq.on("mouseover", function() {
    var a = d3.select(this);
    var a2 = a.attr('font-size');
    a.transition()
    .duration(1000)
    .style('font-size', "40px");
    
    a.transition()
    .delay(2000)
    .duration(1000)
    .style('font-size', a2);
  });
 



