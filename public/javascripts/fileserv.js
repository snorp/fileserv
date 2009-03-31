var back_history = new Array();
var forward_history = new Array();

function browseDirectory(path)
{
  $("#filebrowser").load(path);
}

$().ready(function() {
  $('a.browsedir').live('click', function() {
    var link = $(this);
    browseDirectory(link.attr('href').replace(/\/browse/, '/browse/listing'));
    return false;
  }).attr("rel", "nofollow");
});
