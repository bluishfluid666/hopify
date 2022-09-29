// console.log("Hello")
// $('#select2').select2({
//   theme: 'bootstrap-5',
//   maximumSelectionLength: 10,
//   tokenSeparators: [',', ' '],
//   placeholder: "Select or type keywords",
// })
const addStock = () => {
  const createButton = document.getElementById('addStock');
  // createButton.addEventListener('click', () => {

  //   const lastId = document.querySelector('#fieldsetContainer').lastElementChild.id;
  //   console.log(lastId)

  //   const newId = parseInt(lastId.slice(2), 10) + 1;
  //   // const newId = parseInt(lastId, 10) + 1;
  //   console.log(newId.toString())
  //   console.log(lastId.toString().slice(3))
  //   let pattern = "/fs-"+lastId.toString().slice(3)+"/g"

  //   const newFieldset = document.querySelector('[id="'+'fs-0'+'"]').outerHTML.replace(new RegExp(pattern),newId.toString());
  //   console.log(newFieldset)
  //   document.querySelector('#fieldsetContainer').insertAdjacentHTML(
  //       'beforeend', newFieldset
  //   );
  // });
  createButton.addEventListener("click", () => {

    const lastId = document.querySelector('#fieldsetContainer').lastElementChild.id;

    const newId = parseInt(lastId, 10) + 1;

    const newFieldset = document.querySelector('[id="0"]').outerHTML.replace(/[\"\[\_]0[\"\]\_]/g,function(s){return s[0]+newId.toString()+s.at(-1)});
    // const newFieldset = document.querySelector('[id="0"]').outerHTML.replace(/(?<![0-9])0(?![0-9])/g,newId);

    document.querySelector("#fieldsetContainer").insertAdjacentHTML(
        "beforeend", newFieldset
    );
    // document.querySelector('#size-select').select2({
    //   theme: 'bootstrap-5',
    //   placeholder: "Select or type keywords",
    // })
  });
}

function removeField() {
  document.body.addEventListener("click", (e) => {
    if ( e.target.id === "del-fs" &&
         e.target.parentNode.previousElementSibling) {

/* to prevent from removing the first fieldset as its previous sibling is null */

      e.target.parentNode.remove();
    }
  });
}

// function priceChange(){
//   const sel = document.getElementById('cart_item_product_stock')
//   sel.addEventListener('change',function handleChange(event){
//     console.log(event.target.value)
//   })
// }




export { removeField }
export { addStock }