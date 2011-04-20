$solrProperties = @{
  "solrHost" = "http://localhost:8080/solr/"
};

function solr () {
  $host = $solrProperties.Get_Item("solrHost");
  $query = $args[0];

  if($query.equals("-clean")) {
    curl http://localhost:8080/solr/update/?commit=true -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'
  } elseif($query.equals("-full")) {
    curl "http://localhost:8080/solr/admin/dataimport?command=full-import&verbose" | sed -e 's/<[^<]*>/ /g'
  } elseif($query.equals("-delta")) {
    curl "http://localhost:8080/solr/admin/dataimport?command=delta-import&verbose" | sed -e 's/<[^<]*>/ /g'
  } elseif($query.equals("-status")) {
    curl "http://localhost:8080/solr/admin/dataimport" | sed -e 's/</\n</g' | grep 'str'
  } else{
    echo "http://localhost:8080/solr/select/?q=$query&indent=on&wt=json"
      curl "http://localhost:8080/solr/select/?q=$query&indent=on&wt=json"
  }
}
