function WGraph(container, graph_id,line_ids){
	this.container = container;
	this.line_ids = line_ids;

	var options = {
		legend: { show: false },
		series: {
			stack: true,
			lines: { 
				lineWidth: 0,
				fill: 0.9,
				show: true,
			},
			color: "#ff0000"
		},
		xaxis: {
			mode: 'time'
		},
		grid: {
			show: true,
			aboveData: false,
			color: "black",
			tickColor: "#000000",
			borderWidth: 1,
			borderColor: "#000000",
			hoverable: true,
			autoHighlight: false
		}
	};
	var targetCount = line_ids.length;
	var cumulativeData = [];
	$.each(line_ids,function(index, line_id){
		$.getJSON("/graphs/"+graph_id+"/graph_lines/"+line_id.id+".json", function(data){
			addLine(data);
		});
	});
	
	function addLine(data){
		cumulativeData.push(data);
		if(cumulativeData.length == targetCount){
			console.log(cumulativeData);
			this.plot = $.plot($('#placeholder'), cumulativeData, options);
		}
	}


}

