const collapseTable = () => {
  // $("a[id^=show_]").click(function(event) {
  //     $("#extra_" + $(this).attr('id').substr(5)).slideToggle("slow");
  //     event.preventDefault();
  // });
  document.querySelectorAll('.show-extra').forEach((a)=>{
    a.addEventListener('click', (e)=>{
      e.preventDefault()
      document.querySelector(`#extra_${e.currentTarget.dataset.id}`).classList.toggle('d-none')
    })
  })
}

export { collapseTable };
