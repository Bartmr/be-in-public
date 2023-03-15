import 'source-map-support/register'
import { FunctionResponse } from "../../../shared/function-response";

export async function main(): FunctionResponse<unknown>  {
  console.log('hello 222')
  console.log('hello')
  console.log('hello')




  console.log('hello')
  console.log('hello')

  return {
    body: {"hello": "world"}
  }
}