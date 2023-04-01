## Graph database <https://www.dylanpaulus.com/posts/postgres-is-a-graph-database/>

``` typescript
class Node {
  edges: Edge[] = [];
  data: string;
}

class Edge {
  previousNode: Node;
  nextNode?: Node;
}
```
```sql
CREATE TABLE nodes (
  id SERIAL PRIMARY KEY,
  data VARCHAR(255)
);

CREATE TABLE edges (
  previous_node INTEGER REFERENCES nodes(id),
  next_node INTEGER REFERENCES nodes(id),
  PRIMARY KEY (previous_node, next_node)
);

WITH RECURSIVE friend_of_friend AS (
  SELECT edges.next_node
  FROM edges
  WHERE edges.previous_node = 1
  UNION
  SELECT edges.next_node
  FROM edges
  JOIN friend_of_friend ON edges.previous_node = friend_of_friend.next_node
)
SELECT nodes.data
FROM nodes
JOIN friend_of_friend ON nodes.id = friend_of_friend.next_node;
```
```
WITH RECURSIVE {name} AS (
  {base case}
  UNION
  {recursive case}
)
```