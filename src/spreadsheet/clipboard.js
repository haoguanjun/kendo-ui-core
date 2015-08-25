(function(f, define){
    define([ "../kendo.core" ], f);
})(function(){

(function(kendo) {
    var RangeRef = kendo.spreadsheet.RangeRef;
    var CellRef = kendo.spreadsheet.CellRef;

    var Clipboard = kendo.Class.extend({
        init: function(workbook) {
            this.workbook = workbook;
            this.origin = kendo.spreadsheet.NULLREF;
        },

        canCopy: function() {
            var selection = this.workbook.activeSheet().select();
            if (selection === kendo.spreadsheet.NULLREF) {
                return false;
            }
            if (selection instanceof kendo.spreadsheet.UnionRef) {
                return false;
            }
            return true;
        },

        canPaste: function() {
            var sheet = this.workbook.activeSheet();
            var ref = this.pasteRef();
            if(ref === kendo.spreadsheet.NULLREF) {
                return this._external !== undefined;
            }
            return ref.eq(sheet.unionWithMerged(ref));
        },

        copy: function() {
            var sheet = this.workbook.activeSheet();
            this.origin = sheet.select();
            this.contents = sheet.selection().getState();
        },

        pasteRef: function() {
            var sheet = this.workbook.activeSheet();
            var destination = sheet.activeCell().first();
            var originActiveCell = this.origin.first();
            var rowDelta = originActiveCell.row - destination.row;
            var colDelta = originActiveCell.col - destination.col;

            return this.origin.relative(rowDelta, colDelta, 3);
        },

        paste: function() {
            var content = {};
            var sheet = this.workbook.activeSheet();
            if(this._internal == this._external){
                content = this.contents;
            }else{
                var rows = [];
                var cols = [];
                content = JSON.parse(this._external);
                for (var key in content) {
                    var address = key.split(",");
                    rows.push(address[0]);
                    cols.push(address[1]);
                }
                var topLeft = new CellRef(Math.min.apply(null, rows), Math.min.apply(null, cols));
                var bottomRight = new CellRef(Math.max.apply(null, rows), Math.max.apply(null, cols));
                this.origin = new RangeRef(topLeft, bottomRight, 0);
                $.extend(true, content, {ref: new CellRef(0,0,0), mergedCells: []});
                this._external = undefined;
            }
            var pasteRef = this.pasteRef();
            sheet.range(pasteRef).setState(content);
            sheet.triggerChange({recalc: true});

        },

        internal: function(html) {
            if(html){
                this._internal = JSON.stringify(this.parse(html));
            }else{
                return this._internal;
            }
        },

        external: function(html) {
            if(html){
                this._external = JSON.stringify(this.parse(html));
            }else{
                return this._external;
            }
        },

        parse: function(html) {
            var table = $("<div/>").html(html).find("table:first");
            if(table.length){
                var tbody = table.find("tbody:first");
                var colgroup = table.find("colgroup:first");
                var contents = {};
                tbody.find("tr").each(function(rowIndex, tr) {
                    $(tr).find("td").each(function(colIndex, td) {
                        var key = rowIndex + "," + colIndex;
                        contents[key] = {
                            "value" : $(td).text(),
                            "format" : null,
                            "compiledFormula" : null,
                            "background" : null,
                            "borderBottom" : null,
                            "borderRight" : null,
                            "borderLeft" : null,
                            "borderTop" : null,
                            "color" : null,
                            "fontFamily" : null,
                            "underline" : null,
                            "fontSize" : null,
                            "italic" : null,
                            "bold" : null,
                            "textAlign" : null,
                            "verticalAlign" : null,
                            "wrap" : null
                        };
                    });
                });
                return contents;
            }
            return html;
        }
    });

    kendo.spreadsheet.Clipboard = Clipboard;
})(kendo);
}, typeof define == 'function' && define.amd ? define : function(_, f){ f(); });
