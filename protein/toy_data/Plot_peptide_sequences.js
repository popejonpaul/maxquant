// !preview r2d3 data=c('MAAAAAAAAGDSDSWDADTFSMEDPVRKVAGGGTAGGDRWEGEDEDEDVKDNWDDDDDENKEEAEVKPEVKISEKKKIAEKIKEKERQQKKRQEEIKKRLEEPEESKVLTPEEQLADKLRLKKLQEESDLELAKETFGVNNTVYGIDAMNPSSRDDFTEFGKLLKDKITQYEKSLYYASFLEALVRDVCISLEIDDLKKITNSLTVLCSEKQKQEKQSKAKKKKKGVVPGGGLKATMKDDLADYGGYDGGYVQDYEDFM', 'AAAAAAAAGDSDSWDADTFSMEDPVRK', 'DDFTEFGK', 'GVVPGGGLK', 'ITNSLTVLCSEK', 'LEEPEESK', 'LQEESDLELAK', 'RLEEPEESK'), viewer = "browser"
//
// r2d3: https://rstudio.github.io/r2d3
//

var ProteinSeq = data[0];
var P2 = ProteinSeq.match(/.{1,10}/g);

var colNum = 5;

var rowNum = Math.max(Math.ceil((ProteinSeq.length / 10) / colNum), 1);

var scalex = d3.scaleLinear()
.domain([0, colNum])
.range([0, width]);

var scaley = d3.scaleLinear()
.domain([0, rowNum ])
.range([100, height - 100]);

var seq = svg.selectAll('text')
  .data(P2, function (d, i) { return i;});
var snip=svg.select

var seqtrans = seq.transition()
   .attr('x', function (d, i) { return scalex((i - 1) % colNum);})
   .attr('y', function (d, i) { return scaley(Math.floor((i - 1) / colNum));})
   .text(function(d) { return d; })
   .attr('font-size', "20px");

var seq2 = seq.enter().append('text')
  .attr('x', function (d, i) { return scalex((i - 1) % colNum);})
  .attr('y', function (d, i) { return scaley(Math.floor((i - 1) / colNum));})
  .text(function(d) { return d; })
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
    .attr('fill','red')
    .style('font-size', "40px");
    
    a.transition()
    .delay(2000)
    .duration(1000)
    .attr('fill','blue')
    .style('font-size', a2);
  });