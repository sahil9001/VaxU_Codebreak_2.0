<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    <link href="https://unpkg.com/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js" integrity="sha256-xKeoJ50pzbUGkpQxDYHD7o7hxe0LaOGeguUidbq6vis=" crossorigin="anonymous"></script>
    <script src="./jquery/jquery.min.js"></script>
    <title>Capture Photo</title>
</head>
<body class="bg-gray-200 font-sans leading-normal tracking-normal mt-12">
<nav class="bg-gray-800 pt-2 md:pt-1 pb-1 px-1 mt-0 h-auto fixed w-full z-20 top-0">

<div class="flex flex-wrap items-center">
    <div class="flex flex-shrink md:w-1/3 justify-center md:justify-start text-white">
        <a href="#">
            <span class="text-xl pl-2"><i class="em em-grinning"></i></span>
        </a>
    </div>

    <div class="flex flex-1 md:w-1/3 justify-center md:justify-start text-white px-2">
        <span class="relative w-full">
           
        </span>
    </div>

    <div class="flex w-full pt-2 content-center justify-between md:w-1/3 md:justify-end">
        <ul class="list-reset flex justify-between flex-1 md:flex-none items-center">
            <li class="flex-1 md:flex-none md:mr-3">
                <a class="inline-block py-2 px-4 text-white no-underline" href="./Dashboard.php">Dasboard</a>
            </li>
            <li class="flex-1 md:flex-none md:mr-3">
            <a class="inline-block py-2 px-4 text-white no-underline" href="./verification.php"><i class="fa fa-check"></i>Verify</a>
            </li>
            <li class="flex-1 md:flex-none md:mr-3">
                
            </li>
        </ul>
    </div>
</div>

</nav>

<p><span id="errorMsg"></span></p>

<div class="container" style="margin-left:200px;">
<div class="row">
<div class="col-sm">
<video id="vid"></video>
</div>
<div class="col-sm">
<canvas id="canvas" width="640" height="480"></canvas>
</div>
</div>
</div>
<div class="controller" style="margin-left:680px;margin-top:30px">
<button id="snap" class="btn btn-primary">Capture</button>
<button id="download" class="btn btn-success">Download</button>
</div>


    

</body>

  <script>
  const vid = document.querySelector('video');
navigator.mediaDevices.getUserMedia({video: true}) // request cam
.then(stream => {
  vid.srcObject = stream; // don't use createObjectURL(MediaStream)
  return vid.play(); // returns a Promise
})
.then(()=>{ // enable the button
  const btn = document.getElementById("download")
  btn.disabled = false;
  btn.onclick = e => {
    takeASnap()
    .then(download);
  };
})
.catch(e=>console.log('please use the fiddle instead'));

function takeASnap(){
  const canvas = document.createElement('canvas'); // create a canvas
  const ctx = canvas.getContext('2d'); // get its context
  canvas.width = vid.videoWidth; // set its size to the one of the video
  canvas.height = vid.videoHeight;
  ctx.drawImage(vid, 0,0); // the video
  return new Promise((res, rej)=>{
    canvas.toBlob(res, 'image/jpeg'); // request a Blob from the canvas
  });
}
function download(blob){
  // uses the <a download> to download a Blob
  let a = document.createElement('a'); 
  a.href = URL.createObjectURL(blob);
  a.download = 'screenshot.jpg';
  document.body.appendChild(a);
  a.click();
}
  const video = document.getElementById('vid');
const canvas = document.getElementById('canvas');
const snap = document.getElementById("snap");
const errorMsgElement = document.querySelector('span#errorMsg');
// const download=-1;

const constraints = {
    audio: true,
    video: {
        width: 1280, height: 720
    }
};



// Draw image
var context = canvas.getContext('2d');
snap.addEventListener("click", function() {
    context.drawImage(video, 0, 0, 640, 480);
     
});



  </script>
    

</html>