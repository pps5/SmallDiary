<writearea>
  <form>
    <div class="row">
      <div class="nine columns offset-by-one">
        <textarea class="u-full-width" cols="30" id="text" rows="10"></textarea>
        <input id="submit" class="button-primary" type="button" value="SUBMIT" onclick={ doPost }/>
        <input id="image" class="button-primary" type="button" value="IMAGE"/>
      </div>
    </div>
  </form>

  <style>
   textarea { height: 100px; }
  </style>

  <script>
   var self = this;
   this.on('mount', function() {
       this.textarea = document.querySelector('#text');
   });

   onComplete() {
       self.textarea.value = '';
       self.textarea.removeAttribute('disabled');
   }
   doPost(e) {
       self.textarea.setAttribute('disabled', 'disabled');
       post(this.textarea.value, this.onComplete);
   }
  </script>
</writearea>
