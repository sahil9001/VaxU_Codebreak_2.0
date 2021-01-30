<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Centre Details</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    <link href="https://unpkg.com/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
    <script src="./jquery/jquery.min.js"></script>
    <script src="./fetchDetails.js"></script>
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
                <a class="inline-block text-gray-600 no-underline hover:text-gray-200 hover:text-underline py-2 px-4" href="#"></a>
            </li>
            <li class="flex-1 md:flex-none md:mr-3">
                
            </li>
        </ul>
    </div>
</div>

</nav>
<table class="table table-bordered table-striped">
<thead class="thead-dark">
<tr>
        <th scope="col">Centre Name</th>
        <th scope="col">Phone</th>
        <th scope="col">Description</th>
        <th scope="col">Vaccines available</th>
        <th scope="col">Price</th>
</tr>
<tbody id="table_body">


</tbody>
</thead>
</table>
</body>
</html>