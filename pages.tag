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

  <virtual each={ e in visibleEntries }>
    <page detail={ e }></page>
  </virtual>

  <script>
   const SINGLE_PAGE_MAX = 10;
   var self = this;
   this.maxPageNum = 0;
   this.pageNum = 0;
   this.entries = [];
   this.visibleEntries = [];

   setEntryAddedListener(function(snapshot) {
       var updated = snapshot.val();
       self.entries.unshift(updated);
       self.updateVisibleEntries(true);
       self.maxPageNum = Math.floor(self.entries.length / SINGLE_PAGE_MAX);
       self.update()
   });

   updateVisibleEntries(isAdded) {
       if (isAdded) {
           self.visibleEntries.unshift(self.entries[self.pageNum * SINGLE_PAGE_MAX]);
           if (self.visibleEntries.length > SINGLE_PAGE_MAX) {
               self.visibleEntries.pop();
           }
       } else {
           self.visibleEntries = [];
           var visibleBegin = self.pageNum * SINGLE_PAGE_MAX;
           var visibleEnd = visibleBegin + SINGLE_PAGE_MAX;
           if (visibleEnd > self.entries.length) {
               visibleEnd = self.entries.length;
           }
           for (let i = visibleBegin; i < visibleEnd; i++) {
               self.visibleEntries.push(self.entries[i]);
           }
       }
   }

   goNext() {
       if (this.pageNum < this.maxPageNum) {
           this.pageNum++;
           self.updateVisibleEntries();
       }
   }

   goPrev() {
       if (this.pageNum > 0) {
           this.pageNum--;
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
      <p class="u-full-width text">{ this.text }</p>
      <div class="u-pull-right">{ this.datetime }</div>
    </div>
  </div>

  <script>
   this.text = opts.detail.text;
   this.datetime = new Date(opts.detail.datetime).toLocaleString();
  </script>

  <style>
   page {
       display: block;
       margin: 50px 0;
   }
   .entry-body { border-bottom: 1px solid lightgray; }
   .text { margin: 10px 0; }
  </style>
</page>
