#!/usr/bin/env bats
@test "Docker is available" {
  run docker --version
  [ "$status" -eq 0 ]
}

@test "xq works" {
  run sh -c "cat ./tests/fixtures/test.xml | docker run --rm -i $DOCKER_IMAGE_UNDER_TEST ."
  >&2 echo "ERROR: Test failed: $output"
  [ "$status" -eq 0 ]
  [ "$output" == "$(cat ./tests/fixtures/expected_result.json)" ]
}
