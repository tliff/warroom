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
	var doneCount = 0;
	var cumulativeData = [];
	//FIXME: this should be ordered by the sortindex
	$.each(line_ids,function(index, line_id){
		$.getJSON("/graphs/"+graph_id+"/graph_lines/"+line_id.id+".json", function(data){
			doneCount++;
			addLine(splitDiscontinuity(data));
			if(doneCount == targetCount){
				console.log(cumulativeData);
				this.plot = $.plot($('#placeholder'), cumulativeData.sort(function(a,b){return a.sortindex-b.sortindex;}), options);
			}
		});
	});
	
	function splitDiscontinuity(data){
		var returndata = [];
		var lastdate = null;
		var timeout = 600*1000;
		while(data.data.length > 0){
			sample = data.data.shift();
			if(lastdate && ((lastdate+timeout) < sample[0])){
				returndata.push(null);
			}
			returndata.push(sample);
			lastdate = sample[0];
		}
		i=0;
		data.data = returndata;
		return data;
	}
	
	function addLine(data){
		cumulativeData.push(data);
	}


}

