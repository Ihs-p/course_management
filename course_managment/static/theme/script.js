var i = document.getElementById("theme-icon");
i.onclick = function(){
  document.body.classList.remove()
  document.body.classList.toggle('dark-mode')
  if(document.body.classList.contains('dark-mode')){
    i.src =  'images/moon.png'
  }else{
    i.src = "images/sun.png"
      
  }
}