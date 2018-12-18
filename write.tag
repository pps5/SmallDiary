<writearea>
  <form>
    <div class="row">
      <div class="nine columns offset-by-one">
        <textarea class="u-full-width" cols="30" id="text" rows="10"></textarea>
        <input id="submit" class="button-primary" type="button" value="SUBMIT" onclick={ doPost }/>
        <!-- <input id="image" class="button-primary" type="button" value="IMAGE"/> -->
      </div>
    </div>
  </form>

  <style>
   textarea { height: 100px; resize: vertical; }
  </style>

  <script>
   var self = this;
   self.on('mount', function() {
       self.textarea = document.querySelector('#text');
       self.submit = document.querySelector('#submit');
   });

   onComplete() {
       self.textarea.value = '';
       self.textarea.removeAttribute('disabled');
       self.submit.removeAttribute('disabled');
   }

   doPost(e) {
       var text = self.textarea.value;
       if (text.trim().length > 0) {
           self.submit.setAttribute('disabled', 'disabled');
           self.textarea.setAttribute('disabled', 'disabled');
           post(text, self.onComplete);
       }
   }
  </script>
</writearea>
