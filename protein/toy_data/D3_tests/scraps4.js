// !preview r2d3 data=read.csv("iris.csv"), viewer = "browser"
//
// r2d3: https://rstudio.github.io/r2d3
//






var scalex = d3.scaleLinear()
.domain(d3.extent(data, d => d.SepalLength))
.range([0, width]);

var scaley = d3.scaleLinear()
.domain(d3.extent(data, d => d.SepalWidth))
.range([0, height]);

var scalex2 = d3.scaleLinear()
.domain(d3.extent(data, d => d.PetalLength))
.range([0, width]);

var scaley2 = d3.scaleLinear()
.domain(d3.extent(data, d => d.PetalWidth))
.range([0, height]);

var scaleRandomx = d3.scaleLinear()
  .domain([0, 1])
  .range([0, width]);

var scaleRandomy = d3.scaleLinear()
  .domain([0, 1])
  .range([0, height]);

var scatter1 = svg.selectAll('rect')
  .data(data, function (d) { return d.Key});
  
var scatter2 = scatter1
  .enter().append('rect')
    .attr('width', 10)
    .attr('height', 10)
    .attr('x', function(d) { return scalex(d.SepalLength); })
    .attr('y', function(d) { return scaley(d.SepalWidth); })
    .attr('fill', 'blue');

scatter2
  .transition()
  .delay(500)
  .duration(2000)
  .attr('x', function(d) { return scalex2(d.PetalLength); })
  .attr('y', function(d) { return scaley2(d.PetalWidth); });
  
  
var scatter3 = scatter1
  .exit()
  .transition()
  .duration(500)
  .attr("y", 0)
  .attr("x", height)
  .style("fill-opacity", 1e-6)
  .remove();
  
scatter2.on("click", function() {
          d3.select(this)
          .attr('fill', 'red')
          .transition()
          .duration(1000)
          .attr('x', function(d) { return scaleRandomx(Math.random())})
          .attr('y', function(d) { return scaleRandomy(Math.random())})
          .transition()
          .duration(200)
          .attr('fill', 'black');
        });
        

d3.select("#text1")
  .on("click", function() {
    svg.selectAll('rect')
      .attr('fill', 'green')
      .transition()
      .attr('x', function(d) { return scaleRandomx(Math.random())})
      .attr('y', function(d) { return scaleRandomy(Math.random())})
      .duration(2000)
      .transition()
      .duration(200)
      .attr('fill', 'black');
  });