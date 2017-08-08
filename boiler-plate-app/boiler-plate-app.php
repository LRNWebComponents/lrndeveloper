<?php
/**
 * Callback for apps/boiler-plate-app/data.
 */
function _boiler_plate_app_data($machine_name, $app_route, $params, $args) {
  $return = array();
  $query = new EntityFieldQuery();
  $query->entityCondition('entity_type', 'node')
  ->propertyCondition('status', 1)
  ->propertyOrderBy('changed', 'DESC')
  ->range(0, 25)
  ->execute();
  // flip the results if it found them
  if (isset($result['node'])) {
    foreach ($result['node'] as $item) {
      $node = node_load($item->nid);
      $return[$node->nid]->title = $node->title;
      $return[$node->nid]->author = $node->name;
      if (isset($node->body)) {
        $return[$node->nid]->body = $node->body['und'][0]['safe_value'];
      }
      // theoretical call to get just this node's data
      $return[$node->nid]->url = 'node/' . $node->nid;
    }
  }
  return array(
    'status' => 200,
    'data' => $return
  );
}
