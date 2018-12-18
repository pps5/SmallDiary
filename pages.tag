<pages>
  <div class="row">
    <div class="nine columns offset-by-one">
      <div class="u-pull-right">
        <input type="button" value="<" onclick={ goPrev }/>
        <span class="page-count">{ this.pageNum + 1 }/{ this.maxPageNum + 1 }</span>
        <input type="button" value=">" onclick={ goNext }/>
      </div>
    </div>
  </div>
  <div class="sk-circle">
    <div class="sk-circle1 sk-child"></div>
    <div class="sk-circle2 sk-child"></div>
    <div class="sk-circle3 sk-child"></div>
    <div class="sk-circle4 sk-child"></div>
    <div class="sk-circle5 sk-child"></div>
    <div class="sk-circle6 sk-child"></div>
    <div class="sk-circle7 sk-child"></div>
    <div class="sk-circle8 sk-child"></div>
    <div class="sk-circle9 sk-child"></div>
    <div class="sk-circle10 sk-child"></div>
    <div class="sk-circle11 sk-child"></div>
    <div class="sk-circle12 sk-child"></div>
  </div>
  <virtual each={ e in visibleEntries }>
    <page detail={ e }></page>
  </virtual>

  <script>
   const SINGLE_PAGE_MAX = 10;
   var self = this;
   self.maxPageNum = 0;
   self.pageNum = 0;
   self.entries = [];
   self.visibleEntries = [];

   self.on('mount', function() {
       self.spinner = document.querySelector('.sk-circle');
   });

   setEntryAddedListener(function(snapshot) {
       self.spinner.style.display = 'none';
       var updated = snapshot.val();
       self.entries.unshift(updated);
       self.updateVisibleEntries(true);
       self.maxPageNum = Math.floor(self.entries.length / SINGLE_PAGE_MAX);
       self.update()
   });

   updateVisibleEntries(isAdded) {
       var visibleBegin = self.pageNum * SINGLE_PAGE_MAX;
       var visibleEnd = visibleBegin + SINGLE_PAGE_MAX;
       if (visibleEnd > self.entries.length) {
           visibleEnd = self.entries.length;
       }
       self.visibleEntries = self.entries.slice(visibleBegin, visibleEnd);
   }

   goNext() {
       if (self.pageNum < self.maxPageNum) {
           self.pageNum++;
           self.updateVisibleEntries();
       }
   }

   goPrev() {
       if (self.pageNum > 0) {
           self.pageNum--;
           self.updateVisibleEntries();
       }
   }
  </script>

  <style>
   .page-count { margin: 0 10px; }
  </style>
</pages>

<page>
  <div class="row">
    <div class="nine columns offset-by-one entry-body">
      <div class="u-full-width text">
        <raw content={ this.text }></raw>
      </div>
      <div class="u-pull-right">{ this.datetime }</div>
    </div>
  </div>

  <script>
   this.text = opts.detail.text.replace(/\r?\n/g, '<br>');
   this.datetime = new Date(opts.detail.datetime).toLocaleString();
  </script>

  <style>
   page {
       display: block;
       margin: 50px 0;
   }
   raw { display: block; word-wrap: break-word; }
   .entry-body { border-bottom: 1px solid lightgray; }
   .entry-body * { padding: 0 20px;  }
   .text { margin: 10px 0; }
  </style>
</page>

<raw>
  <span></span>
  this.root.innerHTML = opts.content;
</raw>
