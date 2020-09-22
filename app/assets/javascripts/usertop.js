


const showchart = (level = null) => {
    var request = new XMLHttpRequest();
    
    if (level == null) {
        request.open('GET', '/api/progress', true);
    }else{
       request.open('GET', '/api/progress?level=' + level, true);
    }

    request.responseType = 'json';
 
    request.onload = function () {
      var data = this.response;
      console.log(data);
      
      var ctx = document.getElementById('myChart').getContext('2d');
        var chart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'doughnut',
    
        // The data for our dataset
        data: {
            labels: ['未学習', '学習中', '完了'],
            datasets: [{
                label: 'My First dataset',
                backgroundColor: ['#182a8f', '#7ae64c', '#009427'],
                //borderColor: 'rgb(255, 99, 132)',
                data: [data.not_seen, data.young, data.mature]
            }]
        },
    
        // Configuration options go here
        options: {}
    });
    };
     
    request.send();
}

showchart()

function myFunction() {
    var x = document.getElementById("piSelect").value;
    document.getElementById("demo").innerHTML = "You selected: " + x;
    showchart(x)
}



 

