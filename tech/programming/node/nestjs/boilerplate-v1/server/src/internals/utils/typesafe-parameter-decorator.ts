import type { Abstract, Type } from '@nestjs/common';
import { throwError } from './throw-error';

type Class = Type<unknown> | Abstract<unknown>;

export function EnforceParameterDecoratorTypesafety(
  parameterClass: Class,
): ParameterDecorator {
  const enchancer: ParameterDecorator = (
    target: object,
    propertyKey: string | symbol,
    parameterIndex: number,
  ) => {
    const parametersTypes = Reflect.getMetadata(
      'design:paramtypes',
      target,
      propertyKey,
    ) as Class[];

    const targetDescription = `Parameter [${parameterIndex}] from method ${propertyKey.toString()} in ${
      target.constructor.name
    }`;

    const parameterType =
      parametersTypes[parameterIndex] ||
      throwError(`${targetDescription} does not have a type defined`);

    if (parameterType !== parameterClass) {
      throw new Error(`${targetDescription} must have its type defined as ${parameterClass.name}.
If it's an optional parameter, declare it as 'parameterName?: ${parameterClass.name}'`);
    }
  };

  return enchancer;
}
