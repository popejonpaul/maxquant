// !preview r2d3 data=c('MAAAAAAAAGDSDSWDADTFSMEDPVRKVAGGGTAGGDRWEGEDEDEDVKDNWDDDDDENKEEAEVKPEVKISEKKKIAEKIKEKERQQKKRQEEIKKRLEEPEESKVLTPEEQLADKLRLKKLQEESDLELAKETFGVNNTVYGIDAMNPSSRDDFTEFGKLLKDKITQYEKSLYYASFLEALVRDVCISLEIDDLKKITNSLTVLCSEKQKQEKQSKAKKKKKGVVPGGGLKATMKDDLADYGGYDGGYVQDYEDFM', 'AAAAAAAAGDSDSWDADTFSMEDPVRK', 'DDFTEFGK', 'GVVPGGGLK', 'ITNSLTVLCSEK', 'LEEPEESK', 'LQEESDLELAK', 'RLEEPEESK'), viewer = "browser"


var Proteinseq = data[0];

var textnode = document.createElement("h1");

var colNum = 5;

var rowNum = Math.max(Math.ceil(data.length / colNum), 1);



var scalex = d3.scaleLinear()
.domain([0, colNum])
.range([0, width]);

var scaley = d3.scaleLinear()
.domain([0, rowNum ])
.range([100, height - 100]);



var seq = svg.selectAll('text')
  .data(data, function (d) { return d.Chunk;});
  

var seqtrans = seq.transition()
   .attr('x', function (d, i) { return scalex((d.Chunk - 1) % colNum);})
   .attr('y', function (d, i) { return scaley(Math.floor((d.Chunk - 1) / colNum));})
   .text(function(d) { return d.Sequence; })
   .attr('font-size', "20px");

var seq2 = seq.enter().append('text')
  .attr('x', function (d, i) { return scalex((d.Chunk - 1) % colNum);})
  .attr('y', function (d, i) { return scaley(Math.floor((d.Chunk - 1) / colNum));})
  .text(function(d) { return d.Sequence; })
  .attr('font-size', "20px");

seq.exit()
  .transition()
  .attr('y', height)
  .remove();
  
  
  
seq2.on("mouseover", function() {
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